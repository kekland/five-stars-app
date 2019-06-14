import 'package:five_stars/api/api.dart';
import 'package:five_stars/api/user.dart';
import 'package:five_stars/controllers/registration_page_controller.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/profile_page/profile_edit.dart';
import 'package:flutter/material.dart';

class ProfileEditController extends Controller<ProfileEditPage> {
  ProfileEditController(
      {Presenter<ProfileEditPage, ProfileEditController> presenter}) {
    this.presenter = presenter;

    RegExp emailRegex =
        RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    RegExp phoneRegex =
        RegExp('^[+]*[(]{0,1}[0-9]{1,3}[)]{0,1}[-\s\.\/0-9]*\$');

    email = ValidatedField(
      controller: this,
      textController: emailController,
      errorMessage: "Неверный формат почты",
      validator: (text) => emailRegex.hasMatch(text),
    );

    phoneNumber = ValidatedField(
      controller: this,
      textController: phoneNumberController,
      errorMessage: "Неверный номер телефона",
      validator: (text) => phoneRegex.hasMatch("+7$text"),
    );

    organization = ValidatedField(
      controller: this,
      textController: organizationController,
      errorMessage: "Название организации должно быть длиннее 2 символов",
      validator: (text) => text.length >= 3,
    );

    name = ValidatedField(
      controller: this,
      textController: nameController,
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

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String editingId;
  String username;

  ValidatedField email;
  ValidatedField name;
  ValidatedField organization;
  ValidatedField phoneNumber;

  void setFields(User user) {
    email.setValue(user?.email, true);
    name.setValue("${user?.name?.last} ${user?.name?.first}", true);
    organization.setValue(user?.organization, true);
    phoneNumber.setValue(user?.phoneNumber?.substring(2), true);

    editingId = user.username;
    username = user.username;

    refresh();
  }

  bool isValid() {
    return email.isValid() &&
        name.isValid() &&
        organization.isValid() &&
        phoneNumber.isValid();
  }

  void editProfile(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.indigo);
      await UserApi.editProfile(
        context: context,
        username: username,
        email: email.value,
        firstAndLastName: name.value,
        organization: organization.value,
        validatedPhoneNumber: "+7${phoneNumber.value}",
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showInfoSnackbarMain(message: 'Профиль изменен.');
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showErrorSnackbarMain(
          errorMessage: "Произошла ошибка при изменении профиля", exception: e);
    }
  }
}
