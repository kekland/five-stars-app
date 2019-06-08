import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/views/authorization_page/registration_page.dart';
import 'package:five_stars/views/calls_page/calls_page.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class ValidatedField {
  final Controller controller;
  final TextEditingController textController;
  String value;
  String error;
  String errorMessage;

  bool Function(String text) validator;

  ValidatedField({this.textController, this.controller, this.errorMessage, this.validator});
  void setValue(String newValue, [bool forced = false]) {
    value = newValue;
    if(textController != null && forced) {
      textController.text = value;
    }
  }

  void validate() {
    if (isValid()) {
      error = null;
      controller.refresh();
    } else {
      error = errorMessage;
      controller.refresh();
    }
  }

  bool isValid() {
    if (value == null) return false;
    return validator(value);
  }
}

class RegistrationPageController extends Controller<RegistrationPage> {
  ValidatedField username;
  ValidatedField password;
  ValidatedField passwordSecond;
  ValidatedField email;
  ValidatedField phoneNumber;
  ValidatedField organization;
  ValidatedField firstLastName;

  RegExp emailRegex = RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
  RegExp phoneRegex = RegExp('^[+]*[(]{0,1}[0-9]{1,3}[)]{0,1}[-\s\.\/0-9]*\$');

  RegistrationPageController({Presenter<RegistrationPage, RegistrationPageController> presenter}) {
    this.presenter = presenter;

    username = ValidatedField(
      controller: this,
      errorMessage: "Имя пользователя должно быть длинее 6 символов",
      validator: (text) => text.length >= 7,
    );

    password = ValidatedField(
      controller: this,
      errorMessage: "Пароль должен быть длинее 6 символов",
      validator: (text) => text.length >= 7,
    );

    passwordSecond = ValidatedField(
      controller: this,
      errorMessage: "Пароли не совпадают",
      validator: (text) => text == password.value,
    );

    email = ValidatedField(
      controller: this,
      errorMessage: "Неверный формат почты",
      validator: (text) => emailRegex.hasMatch(text),
    );

    phoneNumber = ValidatedField(
      controller: this,
      errorMessage: "Неверный номер телефона",
      validator: (text) => phoneRegex.hasMatch("+7$text"),
    );

    organization = ValidatedField(
      controller: this,
      errorMessage: "Название организации должно быть длиннее 2 символов",
      validator: (text) => text.length >= 3,
    );

    firstLastName = ValidatedField(
      controller: this,
      errorMessage: "Неверное фамилия или имя",
      validator: (text) {
        List<String> arr = text.split(" ");
        if (arr.length < 2) return false;

        String firstName = arr.first;
        String lastName = arr.last;

        return firstName.isNotEmpty && lastName.isNotEmpty;
      },
    );
  }

  bool get isCorrect {
    return (username.isValid() &&
        password.isValid() &&
        passwordSecond.isValid() &&
        email.isValid() &&
        organization.isValid() &&
        firstLastName.isValid());
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  void register(BuildContext context) async {
    showLoadingDialog(context: context, color: Colors.blue);
    final availability = await ValidityApi.checkUserForAvailability(
        username: username.value, email: email.value, phoneNumber: "+7${phoneNumber.value}");
    
    username.error = (!availability.usernameAvailable)? "Это имя пользователя уже занято" : null;
    email.error = (!availability.emailAvailable)? "Эта почта уже занята" : null;
    phoneNumber.error = (!availability.phoneNumberAvailable)? "Этот номер телефона уже занят" : null;

    if (!availability.available) {
      registrationFailed(
          'Произошла ошибка при регистрации.', Exception('Имя пользователя, почта, либо номер уже заняты.'), context);
      refresh();
      return;
    }

    print("+7${phoneNumber.value}");

    await ValidityApi.verifyPhoneNumber(
      phoneNumber: "+7${phoneNumber.value}",
      onFinished: () => phoneValidationFinished(context),
      onFailed: (e) => registrationFailed('Произошла ошибка при проверке номера телефона.', e, context),
      onCodeSent: (verificationId) {
        Navigator.pop(context);
        showModernDialog(
          context: context,
          title: 'Вам отправлено СМС-сообщение',
          text: 'Когда вам придёт СМС-сообщение с кодом, напишите 6 цифр кода здесь:',
          body: LayoutBuilder(
            builder: (_, constraints) {
              return VerificationCodeInput(
                length: 6,
                itemSize: constraints.maxWidth / 7.0,
                onCompleted: (verificationCode) async {
                  final AuthCredential credential = PhoneAuthProvider.getCredential(
                    verificationId: verificationId,
                    smsCode: verificationCode,
                  );

                  try {
                    Navigator.pop(context);
                    showLoadingDialog(context: context, color: Colors.blue);
                    await auth.signInWithCredential(credential);
                    phoneValidationFinished(context);
                  } catch (e) {
                    print(e);
                    registrationFailed(
                        'Произошла ошибка при проверке номера телефона, скорее всего неправильный код с СМС.',
                        e,
                        context);
                  }
                },
              );
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(),
              textColor: Colors.deepPurple,
            ),
          ],
        );
      },
    );
  }

  void phoneValidationFinished(BuildContext context) async {
    try {
      await Api.register(
        username: username.value,
        password: password.value,
        email: email.value,
        validatedPhoneNumber: "+7${phoneNumber.value}",
        firstAndLastName: firstLastName.value,
        organization: organization.value,
      );

      String token = await Api.getToken(username: username.value, password: password.value);
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed("/main");
    } catch (e) {
      registrationFailed('Произошла ошибка при регистрации.', e, context);
    }
  }

  void registrationFailed(String text, Exception e, BuildContext context) {
    Navigator.pop(context);

    showErrorSnackbar(
      context: context,
      errorMessage: text,
      exception: e,
      showDialog: (e != null),
    );
  }
}
