import 'package:dio/dio.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/authorization_page/login_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:five_stars/Api/Api.dart';

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
      String token = await Api.getToken(username: username, password: password);
      Navigator.of(context).pushReplacementNamed("/main");
    } catch (e) {
      Navigator.of(context).pop();
      if (e is DioError && e.response != null) {
        if (e.response.data['message'] == 'Invalid username or password') {
          showErrorSnackbar(
              context: context, errorMessage: 'Неправильный логин или пароль', exception: e, showDialog: true);
          return;
        }
      }
      showErrorSnackbar(
          context: context, errorMessage: 'Произошла ошибка при входе в систему', exception: e, showDialog: true);
    }
  }
}
