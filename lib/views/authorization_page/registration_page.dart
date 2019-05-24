import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/controllers/registration_page_controller.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key key,
    @required this.focusNode,
    this.onLogin,
  }) : super(key: key);

  final FocusNode focusNode;
  final VoidCallback onLogin;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends Presenter<RegistrationPage, RegistrationPageController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget present(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Регистрация', style: ModernTextTheme.boldTitle.copyWith(fontSize: 24.0), textAlign: TextAlign.center),
            Text('Создать новый аккаунт', style: ModernTextTheme.caption),
            SizedBox(height: 32.0),
            ModernTextField(
              hintText: 'Имя пользователя',
              icon: Icons.person,
              onSubmitted: controller.username.validate,
              onChanged: controller.username.setValue,
              error: controller.username.error,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              hintText: 'Пароль',
              obscureText: true,
              icon: Icons.lock,
              onSubmitted: controller.password.validate,
              onChanged: controller.password.setValue,
              error: controller.password.error,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              hintText: 'Повторите пароль',
              obscureText: true,
              icon: Icons.lock,
              onSubmitted: controller.passwordSecond.validate,
              onChanged: controller.passwordSecond.setValue,
              error: controller.passwordSecond.error,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              hintText: 'Почта',
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
              onSubmitted: controller.email.validate,
              onChanged: controller.email.setValue,
              error: controller.email.error,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              hintText: 'Номер телефона',
              prefix: Text(
                "+7",
                style: TextStyle(
                    fontSize: 16.0, color: Colors.black, fontFamily: "Inter", textBaseline: TextBaseline.alphabetic),
              ),
              keyboardType: TextInputType.phone,
              icon: Icons.phone,
              onSubmitted: controller.phoneNumber.validate,
              onChanged: controller.phoneNumber.setValue,
              error: controller.phoneNumber.error,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              hintText: 'Организация',
              keyboardType: TextInputType.text,
              icon: Icons.work,
              onSubmitted: controller.organization.validate,
              onChanged: controller.organization.setValue,
              error: controller.organization.error,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              hintText: 'Фамилия и имя',
              keyboardType: TextInputType.text,
              icon: Icons.person,
              onSubmitted: controller.firstLastName.validate,
              onChanged: controller.firstLastName.setValue,
              error: controller.firstLastName.error,
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: controller.isCorrect? controller.register : null,
                shape: StadiumBorder(),
                icon: Icon(Icons.chevron_right),
                label: Text('Зарегистрироваться'),
                color: Colors.blue,
                disabledColor: Colors.black12,
                textColor: Colors.white,
              ),
            ),
            FlatButton.icon(
              label: Text('Или может, войти?'),
              onPressed: widget.onLogin,
              icon: Icon(Icons.chevron_left),
              textColor: ModernTextTheme.captionColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initController() {
    controller = RegistrationPageController(presenter: this);
  }
}
