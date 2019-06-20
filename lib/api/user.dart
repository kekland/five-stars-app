import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:flutter/material.dart';

class UserApi {
  static Future<User> getProfile(
      {@required BuildContext context, String username}) async {
    try {
      final response = await Api.client.get('$baseUrl/user/$username');
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<User> editProfile({
    @required BuildContext context,
    String username,
    String email,
    String validatedPhoneNumber,
    String organization,
    String firstAndLastName,
  }) async {
    try {
      List<String> names = firstAndLastName.split(" ");
      final response = await Api.client.put(
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
      return User.fromJson(response.data);
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

  static Future<List<Cargo>> getUserCargo({
    @required BuildContext context,
    String username,
    bool favorites = false,
  }) async {
    try {
      final response = await Api.client.get(
        '$baseUrl/user/$username/cargo' + ((favorites)? '/favorite' : ''),
      );
      return (response.data as List).map((o) => Cargo.fromJson(o)).cast<Cargo>().toList();
    } catch (e) {
      rethrow;
    }
  }
  
  static Future<List<Vehicle>> getUserVehicles({
    @required BuildContext context,
    String username,
    bool favorites = false,
  }) async {
    try {
      final response = await Api.client.get(
        '$baseUrl/user/$username/vehicle' + ((favorites)? '/favorite' : ''),
      );
      return (response.data as List).map((o) => Vehicle.fromJson(o)).cast<Vehicle>().toList();
    } catch (e) {
      rethrow;
    }
  }
}
