import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/user_model.dart';

class UserApi {
  static Future<User> getProfile(String username) async {
    try {
      final response =
          await Dio().get('$baseUrl/cargo', options: Api.options);
      
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
}