
import 'package:five_stars/controllers/login_page_controller.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
    @required this.focusNode, this.onRegister,
  }) : super(key: key);

  final FocusNode focusNode;
  final VoidCallback onRegister;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends Presenter<LoginPage, LoginPageController> {
  @override
  Widget present(BuildContext context) {
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
              hintText: 'Почта',
              icon: Icons.person,
              onChanged: controller.setUsername,
            ),
            SizedBox(height: 16.0),
            ModernTextField(
              hintText: 'Пароль',
              obscureText: true,
              icon: Icons.lock,
              onChanged: controller.setPassword,
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () => controller.login(context),
                shape: StadiumBorder(),
                icon: Icon(Icons.chevron_right),
                label: Text('Вход в систему'),
                color: Colors.red,
                textColor: Colors.white,
              ),
            ),
            FlatButton.icon(
              label: Text('Или может, зарегистрироваться?'),
              onPressed: widget.onRegister,
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
    controller = LoginPageController(presenter: this);
  }
}
