import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/views/authorization_page/login_page.dart';
import 'package:five_stars/views/authorization_page/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> with SingleTickerProviderStateMixin {
  FocusNode focusNode;
  int currentPage = 1;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    focusNode = null;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = CurvedAnimation(curve: Curves.easeInOut, parent: controller);

    controller.addListener(() => setState(() => {}));

    super.initState();
  }

  void onLogin() {
    controller.forward(from: 0.0);
  }

  void onRegister() {
    controller.reverse(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Offstage(
              offstage: animation.value == 1.0,
              child: Transform.translate(
                offset: Offset(0.0, 10.0 * animation.value),
                child: Opacity(
                  opacity: 1.0 - animation.value,
                  child: RegistrationPage(focusNode: focusNode, onLogin: onLogin),
                ),
              ),
            ),
            Offstage(
              offstage: animation.value == 0.0,
              child: Transform.translate(
                offset: Offset(0.0, 10.0 * (1.0 - animation.value)),
                child: Opacity(
                  opacity: animation.value,
                  child: LoginPage(focusNode: focusNode, onRegister: onRegister),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
