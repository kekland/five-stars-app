import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/api/api.dart';
import 'package:flutter/widgets.dart';

class UserRegistrationAvailability {
  bool usernameAvailable;
  bool emailAvailable;
  bool phoneNumberAvailable;

  UserRegistrationAvailability.fromJson(Map<String, dynamic> json) {
    print("$json");
    usernameAvailable = json['usernameAvailable'] as bool;
    emailAvailable = json['emailAvailable'] as bool;
    phoneNumberAvailable = json['phoneNumberAvailable'] as bool;
    print("Xd");
  }

  bool get available {
    return usernameAvailable && emailAvailable && phoneNumberAvailable;
  }
}

Future<UserRegistrationAvailability> checkUserForAvailability({String username, String email, String phoneNumber}) async {
  final result = await Dio().post('$baseUrl/user/valid', data: {
    "username": username,
    "email": email,
    "phoneNumber": phoneNumber,
  });

  return UserRegistrationAvailability.fromJson(result.data);
}

final FirebaseAuth auth = FirebaseAuth.instance;
Future verifyPhoneNumber(
    {Function(Exception) onFailed,
    Function(String verificationId) onCodeSent,
    Function onFinished,
    String phoneNumber}) async {
  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: Duration.zero,
    codeSent: (verificationId, [forceResending]) => onCodeSent(verificationId),
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
