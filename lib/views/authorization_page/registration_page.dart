import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    Key key,
    @required this.focusNode,
    this.onLogin,
  }) : super(key: key);

  final FocusNode focusNode;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Регистрация', style: ModernTextTheme.boldTitle.copyWith(fontSize: 24.0), textAlign: TextAlign.center),
            Text('Создать новый аккаунт', style: ModernTextTheme.caption),
            SizedBox(height: 32.0),
            ModernTextField(
              focusNode: focusNode,
              hintText: 'Имя пользователя',
              icon: Icons.person,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              focusNode: focusNode,
              hintText: 'Пароль',
              obscureText: true,
              icon: Icons.lock,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              focusNode: focusNode,
              hintText: 'Почта',
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              focusNode: focusNode,
              hintText: 'Номер телефона',
              prefix: Text(
                "+7",
                style: TextStyle(
                    fontSize: 16.0, color: Colors.black, fontFamily: "Inter", textBaseline: TextBaseline.alphabetic),
              ),
              keyboardType: TextInputType.phone,
              icon: Icons.phone,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              focusNode: focusNode,
              hintText: 'Организация',
              keyboardType: TextInputType.text,
              icon: Icons.work,
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () => Navigator.of(context).pushReplacementNamed("/auth"),
                shape: StadiumBorder(),
                icon: Icon(Icons.chevron_right),
                label: Text('Зарегистрироваться'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
            FlatButton.icon(
              label: Text('Или может, войти?'),
              onPressed: onLogin,
              icon: Icon(Icons.chevron_left),
              textColor: ModernTextTheme.captionColor,
            ),
          ],
        ),
      ),
    );
  }
}
