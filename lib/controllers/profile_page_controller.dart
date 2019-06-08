import 'package:five_stars/api/user.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/calls_page/calls_page.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:flutter/material.dart';

class ProfilePageController extends Controller<ProfilePage> {
  bool isLoading;
  bool firstLoad = true;
  User data;

  ProfilePageController({Presenter<ProfilePage, ProfilePageController> presenter}) {
    this.presenter = presenter;
  }

  Future load({BuildContext context, String username}) async {
    data = null;
    isLoading = true;
    refresh();
    try {
      data = await UserApi.getProfile(username);
    }
    catch(e) {
      data = null;
      showErrorSnackbar(context: context, errorMessage: "Произошла ошибка при получении профиля", exception: e);
    }

    isLoading = false;
    firstLoad = false;
    refresh();
  }
}
