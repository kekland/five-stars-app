import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:flutter/material.dart';

class UserApi {
  static Future<User> getProfile(
      {@required BuildContext context, String uid}) async {
    try {
      final snapshot = await Firestore.instance.collection('users').document(uid).get();
      if(snapshot == null) throw Exception('Пользователь не найден.');
      return User.fromJson(snapshot.data)..uid = uid;
    } catch (e) {
      rethrow;
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
