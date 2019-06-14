import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/api/api.dart';
import 'package:flutter/widgets.dart';

class UserRegistrationAvailability {
  bool usernameAvailable;
  bool emailAvailable;
  bool phoneNumberAvailable;

  UserRegistrationAvailability(
      {this.usernameAvailable, this.emailAvailable, this.phoneNumberAvailable});

  UserRegistrationAvailability.fromJson(Map<String, dynamic> json) {
    print("$json");
    usernameAvailable = !(json['usernameTaken'] as bool);
    emailAvailable = !(json['emailTaken'] as bool);
    phoneNumberAvailable = !(json['phoneNumberTaken'] as bool);
    print("Xd");
  }

  bool get available {
    return usernameAvailable && emailAvailable && phoneNumberAvailable;
  }
}

class ValidityApi {
  static Future<UserRegistrationAvailability> checkUserForAvailability(
      {String username, String email, String phoneNumber}) async {
    final usernameSnapshot = await Firestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();
    final emailSnapshot = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    final phoneSnapshot = await Firestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .getDocuments();
    return UserRegistrationAvailability(
      emailAvailable: emailSnapshot.documents.length == 0,
      phoneNumberAvailable: phoneSnapshot.documents.length == 0,
      usernameAvailable: usernameSnapshot.documents.length == 0,
    );
  }

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static Future verifyPhoneNumber(
      {Function(Exception) onFailed,
      Function(String verificationId) onCodeSent,
      Function onFinished,
      String phoneNumber}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 30),
      codeSent: (verificationId, [forceResending]) =>
          onCodeSent(verificationId),
      verificationFailed: (exception) {
        print(exception.message);
        onFailed(exception);
      },
      codeAutoRetrievalTimeout: (t) {
        print("codeAuthRetrievalTimeout $t");
      },
      verificationCompleted: (cred) {
        onFinished();
      },
    );
  }
}
