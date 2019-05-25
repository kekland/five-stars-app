import 'dart:io';
import 'package:five_stars/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
export 'package:five_stars/api/validity.dart';

String baseUrl = 'http://192.168.1.104:8888';
//String baseUrl = 'https://api.5zvezd.kz';

Future<bool> register({
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
      '$baseUrl/user',
      data: {
        "username": username,
        "password": password,
        "email": email,
        "phoneNumber": validatedPhoneNumber,
        "firstName": names.last,
        "lastName": names.first,
        "middleName": "",
        "organization": organization,
      },
    );

    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    rethrow;
  }
}

Future<String> getToken({
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
      "$baseUrl/auth",
      queryParameters: {
        "username": username,
        "password": password,
        "grant_type": "password",
      },
      options: Options(
        headers: {"Authorization": "Basic Y29tLmtla2xhbmQuZml2ZV9zdGFyczo="},
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      print(response.data);

      SharedPreferencesManager.instance.setString("username", username);
      SharedPreferencesManager.instance.setString("password", password);
      SharedPreferencesManager.instance.setString("token", response.data['access_token']);

      return response.data["access_token"];
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}
