import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/api/user.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/authorization_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:five_stars/api/api.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';

class LoginPageController extends Controller<LoginPage> {
  LoginPageController({Presenter<LoginPage, LoginPageController> presenter}) {
    this.presenter = presenter;
  }

  String username;
  String password;
  RegExp phoneRegex = RegExp('^[+]*[(]{0,1}[0-9]{1,3}[)]{0,1}[-\s\.\/0-9]*\$');

  void setUsername(String text) => username = text;
  void setPassword(String text) => password = text;

  final FirebaseAuth auth = FirebaseAuth.instance;
  void login(BuildContext context) async {
    showLoadingDialog(color: Colors.blue, context: context);
    try {
      final token = await Api.getToken(username: username, password: password);
      Navigator.of(context).pushNamedAndRemoveUntil("/main", (_) => true);
    } catch (e) {
      await Navigator.of(context).maybePop();
      if (e is DioError && e.response != null) {
        if ((e.response.data is Map) &&
            e.response.data['message'] == 'Invalid email or password') {
          showErrorSnackbar(
              context: context,
              errorMessage: 'Неправильный логин или пароль',
              exception: e,
              showDialog: true);
          return;
        }
      }
      showErrorSnackbar(
          context: context,
          errorMessage: 'Произошла ошибка при входе в систему',
          exception: e,
          showDialog: true);
    }
  }

  void forgotPassword(BuildContext context) async {
    TextEditingController phoneController = TextEditingController(
      text: '',
    );
    TextEditingController passwordController = TextEditingController(
      text: '',
    );

    Map data = await showModernDialog(
      context: context,
      title: 'Введите данные',
      body: StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ModernTextField(
                controller: phoneController,
                hintText: 'Номер телефона',
                prefix: Text(
                  "+7",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontFamily: "Inter",
                      textBaseline: TextBaseline.alphabetic),
                ),
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
                onChanged: (_) => setState(() {}),
                error: (!phoneRegex.hasMatch("+7${phoneController.text}"))
                    ? 'Неправильное значение'
                    : null,
              ),
              SizedBox(height: 16.0),
              ModernTextField(
                controller: passwordController,
                hintText: 'Новый пароль',
                obscureText: true,
                icon: Icons.lock,
                onChanged: (_) => setState(() {}),
                error: (passwordController.text.length < 7)
                    ? 'Пароль должен быть длинее 6 символов'
                    : null,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      child: Text('Отмена'),
                      onPressed: () => Navigator.of(context).pop()),
                  FlatButton(
                    child: Text('Продолжить'),
                    textColor: Colors.indigo,
                    onPressed:
                        (phoneRegex.hasMatch("+7${phoneController.text}") &&
                                passwordController.text.length >= 7)
                            ? () => Navigator.of(context).pop({
                                  'phone': phoneController.text,
                                  'password': passwordController.text,
                                })
                            : null,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );

    if (data != null) {
      showLoadingDialog(context: context, color: Colors.blue);

      await ValidityApi.verifyPhoneNumber(
        phoneNumber: "+7${data['phone']}",
        onFinished: (cred) => phoneValidationFinished(
          context,
          data['phone'],
          data['password'],
          cred,
        ),
        onFailed: (e) => registrationFailed(
            'Произошла ошибка при проверке номера телефона.', e, context),
        onCodeSent: (verificationId) async {
          await Navigator.maybePop(context);
          showModernDialog(
            context: context,
            title: 'Вам отправлено СМС-сообщение',
            text:
                'Когда вам придёт СМС-сообщение с кодом, напишите 6 цифр кода здесь:',
            body: LayoutBuilder(
              builder: (_, constraints) {
                return VerificationCodeInput(
                  length: 6,
                  itemSize: constraints.maxWidth / 7.0,
                  onCompleted: (verificationCode) => verifyCode(
                    context: context,
                    verificationCode: verificationCode,
                    verificationId: verificationId,
                    phoneNumber: data['phone'],
                    password: data['password'],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Отмена'),
                onPressed: () => Navigator.of(context).maybePop(),
                textColor: Colors.deepPurple,
              ),
            ],
          );
        },
      );
    }
  }

  void verifyCode(
      {BuildContext context,
      String verificationCode,
      String verificationId,
      String phoneNumber,
      String password}) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: verificationCode,
    );

    try {
      await Navigator.maybePop(context);
      showLoadingDialog(context: context, color: Colors.blue);

      phoneValidationFinished(context, phoneNumber, password, credential);
    } catch (e) {
      print(e);
      registrationFailed(
          'Произошла ошибка при проверке номера телефона, скорее всего неправильный код с СМС.',
          e,
          context);
    }
  }

  void phoneValidationFinished(
    BuildContext context,
    String phoneNumber,
    String newPassword,
    AuthCredential cred,
  ) async {
    FirebaseUser user;
    try {
      user = await auth.signInWithCredential(cred);

      await Api.changePassword(
        phoneNumber: '+7$phoneNumber',
        newPassword: newPassword,
      );

      await Navigator.maybePop(context);
      showInfoSnackbar(context: context, message: 'Пароль изменён.');
    } catch (e) {
      await user.delete();
      registrationFailed('Произошла ошибка при изменении пароля.', e, context);
    }
  }

  void registrationFailed(String text, dynamic e, BuildContext context) async {
    await Navigator.maybePop(context);

    showErrorSnackbar(
      context: context,
      errorMessage: text,
      exception: e,
      showDialog: (e != null),
    );
  }

  void loginAsGuest(BuildContext context) async {
    AppData.username = null;
    Navigator.of(context).pushReplacementNamed("/main");
  }
}
