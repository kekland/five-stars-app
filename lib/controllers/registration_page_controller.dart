import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:five_stars/views/authorization_page/registration_page.dart';
import 'package:five_stars/views/calls_page/calls_page.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:flutter/material.dart';

class ValidatedField {
  final Controller controller;
  String value;
  String error;
  String errorMessage;

  bool Function(String text) validator;

  ValidatedField({this.controller, this.errorMessage, this.validator});
  void setValue(String newValue) {
    value = newValue;
  }

  void validate() {
    if (isValid()) {
      error = null;
      controller.refresh();
    } else {
      error = errorMessage;
      controller.refresh();
    }
  }

  bool isValid() {
    if (value == null) return false;
    return validator(value);
  }
}

class RegistrationPageController extends Controller<RegistrationPage> {
  ValidatedField username;
  ValidatedField password;
  ValidatedField passwordSecond;
  ValidatedField email;
  ValidatedField phoneNumber;
  ValidatedField organization;
  ValidatedField firstLastName;

  RegExp emailRegex = RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
  RegExp phoneRegex = RegExp('^[+]*[(]{0,1}[0-9]{1,3}[)]{0,1}[-\s\.\/0-9]*\$');

  RegistrationPageController({Presenter<RegistrationPage, RegistrationPageController> presenter}) {
    this.presenter = presenter;

    username = ValidatedField(
      controller: this,
      errorMessage: "Имя пользователя должно быть длинее 6 символов",
      validator: (text) => text.length >= 7,
    );

    password = ValidatedField(
      controller: this,
      errorMessage: "Пароль должен быть длинее 6 символов",
      validator: (text) => text.length >= 7,
    );

    passwordSecond = ValidatedField(
      controller: this,
      errorMessage: "Пароли не совпадают",
      validator: (text) => text == password.value,
    );

    email = ValidatedField(
      controller: this,
      errorMessage: "Неверный формат почты",
      validator: (text) => emailRegex.hasMatch(text),
    );

    phoneNumber = ValidatedField(
      controller: this,
      errorMessage: "Неверный номер телефона",
      validator: (text) => phoneRegex.hasMatch("+7$text"),
    );

    organization = ValidatedField(
      controller: this,
      errorMessage: "Название организации должно быть длиннее 2 символов",
      validator: (text) => text.length >= 3,
    );

    firstLastName = ValidatedField(
      controller: this,
      errorMessage: "Неверное фамилия или имя",
      validator: (text) {
        List<String> arr = text.split(" ");
        if (arr.length < 2) return false;

        String firstName = arr.first;
        String lastName = arr.last;

        return firstName.isNotEmpty && lastName.isNotEmpty;
      },
    );
  }

  bool get isCorrect {
    return (username.isValid() &&
        password.isValid() &&
        passwordSecond.isValid() &&
        email.isValid() &&
        organization.isValid() &&
        firstLastName.isValid());
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  void register() {
    
  }
}
