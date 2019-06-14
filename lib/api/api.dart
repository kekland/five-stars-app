import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
export 'package:five_stars/api/validity.dart';
export 'package:five_stars/api/cargo.dart';

//String baseUrl = 'http://192.168.1.104:3008';

String baseUrl = 'https://api.5zvezd.kz';

class Api {
  static Future<FirebaseUser> register({User userData, FirebaseUser user, String password}) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userData.email, password: password);
      
      final ref = await Firestore.instance.collection('users').document(user.uid).setData(
        {
          ...userData.toJson(),
          "cargo": [],
          "vehicles": [],
          "savedCargoData": [],
          "savedVehicleData": [],
          "favoriteCargoData": [],
          "favoriteVehicleData": [],
        },
      );
      
      AppData.username = userData.username;
      AppData.uid = user.uid;
      
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> handleError(
      {@required BuildContext context, dynamic exception}) async {
    /*try {
      if (exception is DioError) {
        if (exception.response.statusCode == 401) {
          await getToken(context: context);
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
    }*/
    return false;
  }

  static void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  static Options get options => Options(headers: {
        "Authorization":
            "Bearer ${SharedPreferencesManager.instance.getString("token")}",
      });
}
