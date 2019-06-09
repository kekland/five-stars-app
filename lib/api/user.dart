import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:flutter/material.dart';

class UserApi {
  static Future<User> getProfile(
      {@required BuildContext context, String username}) async {
    try {
      final response =
          await Dio().get('$baseUrl/user/$username', options: Api.options);

      return User.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await getProfile(context: context, username: username);
      } else {
        rethrow;
      }
    }
  }

  static Future editProfile({
    @required BuildContext context,
    String username,
    String email,
    String validatedPhoneNumber,
    String organization,
    String firstAndLastName,
  }) async {
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
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await editProfile(
          context: context,
          username: username,
          email: email,
          validatedPhoneNumber: validatedPhoneNumber,
          organization: organization,
          firstAndLastName: firstAndLastName,
        );
      } else {
        rethrow;
      }
    }
  }
}
