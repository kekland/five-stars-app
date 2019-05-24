
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key key,
    @required this.focusNode, this.onRegister,
  }) : super(key: key);

  final FocusNode focusNode;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Войти', style: ModernTextTheme.boldTitle.copyWith(fontSize: 24.0), textAlign: TextAlign.center),
            Text('Вход в систему', style: ModernTextTheme.caption),
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
            SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () => Navigator.of(context).pushReplacementNamed("/auth"),
                shape: StadiumBorder(),
                icon: Icon(Icons.chevron_right),
                label: Text('Вход в систему'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
            FlatButton.icon(
              label: Text('Или может, зарегистрироваться?'),
              onPressed: onRegister,
              icon: Icon(Icons.chevron_left),
              textColor: ModernTextTheme.captionColor,
            ),
          ],
        ),
      ),
    );
  }
}
