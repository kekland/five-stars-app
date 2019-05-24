import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

String baseUrl = 'https://api.5zvezd.kz';

Map<String, String> getHeaders() {
  return {
    "Content-Type": "application/json",
  };
}

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
      options: Options(
        headers: getHeaders(),
      ),
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
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}
