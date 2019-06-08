import 'dart:io';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
export 'package:five_stars/api/validity.dart';
export 'package:five_stars/api/cargo.dart';

String baseUrl = 'http://192.168.1.104:3008';

//String baseUrl = 'https://api.5zvezd.kz';

class Api {
  static Future<bool> register({
    String username,
    String password,
    String email,
    String validatedPhoneNumber,
    String organization,
    String firstAndLastName,
  }) async {
    try {
      List<String> names = firstAndLastName.split(" ");
      final response = await Dio().post(
        '$baseUrl/auth/register',
        data: {
          "username": username,
          "password": password,
          "email": email,
          "phoneNumber": validatedPhoneNumber,
          "name": {
            "first": names.last,
            "last": names.first,
          },
          "organization": organization,
        },
      );

      print(response.data);
      print(response.statusCode);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getToken({
    String username,
    String password,
  }) async {
    try {
      if (username == null) {
        username = SharedPreferencesManager.instance.getString("username");
      }
      if (password == null) {
        password = SharedPreferencesManager.instance.getString("password");
      }

      final response = await Dio().post(
        "$baseUrl/auth/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      SharedPreferencesManager.instance.setString("username", username);
      SharedPreferencesManager.instance.setString("password", password);
      AppData.username = username;
      SharedPreferencesManager.instance
          .setString("token", response.data['token']);

      return response.data["token"];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> handleError(dynamic e) async {
    try {
      if (e is DioError) {
        if (e.response.statusCode == 401) {
          await getToken();
          return true;
        }
        return false;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  static Options get options => Options(headers: {
        "Authorization":
            "Bearer ${SharedPreferencesManager.instance.getString("token")}",
      });
}
