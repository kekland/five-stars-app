import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
export 'package:five_stars/api/validity.dart';
export 'package:five_stars/api/cargo.dart';

String baseUrl = 'http://192.168.1.104:3008';

// String baseUrl = 'https://api.5zvezd.kz';

class Api {
  static Future<String> register(
      {BuildContext context, User userData, String password}) async {
    try {
      final response = await Dio().post('$baseUrl/auth/register', data: {
        "username": userData.username,
        "password": password,
        "email": userData.email,
        "phoneNumber": userData.phoneNumber,
        "organization": userData.organization,
        "name": userData.name.toJson(),
      });

      AppData.username = userData.username;

      return await getToken(
          context: context, username: userData.username, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getToken(
      {BuildContext context, String username, String password}) async {
    try {
      final response = await Dio().post('$baseUrl/auth/login', data: {
        "username": username,
        "password": password,
      });
      print(response);

      final token = response.data['token'];

      AppData.username = username;
      AppData.token = token;
      await SharedPreferencesManager.instance.setString('password', password);

      return token;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> handleError(
      {@required BuildContext context, dynamic exception}) async {
    print(exception);
    try {
      if (exception is DioError) {
        if (exception.response.statusCode == 401) {
          if (AppData.username == null ||
              SharedPreferencesManager.instance.getString('password') == null) {
            logOut(context);
            return false;
          }
          await getToken(
            context: context,
            username: AppData.username,
            password: SharedPreferencesManager.instance.getString('password'),
          );
          return true;
        }
        return false;
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null &&
            error.response.data != null &&
            (error.response.data['message'] == 'Invalid JWT token' ||
                error.response.data['message'] ==
                    'Invalid username or password')) {
          logOut(context);
        }
      }
      return false;
    }
    return false;
  }

  static void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  static Options get options =>
      Options(headers: {"Authorization": "Bearer ${AppData.token}"});
}
