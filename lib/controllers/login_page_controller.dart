import 'package:dio/dio.dart';
import 'package:five_stars/api/user.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/authorization_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:five_stars/api/api.dart';

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
      final token = await Api.getToken(username: username, password: password);
      Navigator.of(context).pushReplacementNamed("/main");
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

  void loginAsGuest(BuildContext context) async {
    AppData.username = null;
    Navigator.of(context).pushReplacementNamed("/main");
  }
}
