import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:five_stars/views/calls_page/calls_page.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:flutter/material.dart';

class ProfilePageController extends Controller<ProfilePage> {
  ProfilePageController({Presenter<ProfilePage, ProfilePageController> presenter}) {
    this.presenter = presenter;
  }
}
