import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/user_model.dart';

class UserApi {
  static Future<User> getProfile(String username) async {
    try {
      final response =
          await Dio().get('$baseUrl/user/$username', options: Api.options);

      return User.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await getProfile(username);
      } else {
        rethrow;
      }
    }
  }

  static Future editProfile(
      {String username,
      String email,
      String validatedPhoneNumber,
      String organization,
      String firstAndLastName}) async {
    try {
      List<String> names = firstAndLastName.split(" ");
      final response = await Dio().put(
        '$baseUrl/user/${username}',
        data: {
          "email": email,
          "phoneNumber": validatedPhoneNumber,
          "name": {
            "first": names.last,
            "last": names.first,
          },
          "organization": organization,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
