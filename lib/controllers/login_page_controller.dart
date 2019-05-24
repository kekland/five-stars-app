import 'package:dio/dio.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/authorization_page/login_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:five_stars/api/api.dart' as api;

class LoginPageController extends Controller<LoginPage> {
  LoginPageController({Presenter<LoginPage, LoginPageController> presenter}) {
    this.presenter = presenter;
  }

  String username;
  String password;

  void setUsername(String text) => username = text;
  void setPassword(String text) => password = text;

  void login(BuildContext context) async {
    showLoadingDialog(color: Colors.blue, context: context);
    try {
      String token = await api.getToken(username: username, password: password);
      Navigator.of(context).pushReplacementNamed("/main");
    } catch (e) {
      Navigator.of(context).pop();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Произошла ошибка при входе в систему.'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Подробнее",
          onPressed: () {
            showModernDialog(
              text: (e is DioError)? "${e.message} ${e.response.data}" : e.toString(),
              title: 'Ошибка',
              context: context,
              actions: <Widget>[
                FlatButton(
                  child: Text('Закрыть'),
                  onPressed: () => Navigator.of(context).pop(),
                  textColor: Colors.blue,
                ),
              ],
            );
          },
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ));
    }
  }
}
