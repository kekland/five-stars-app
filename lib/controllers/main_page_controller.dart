import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:five_stars/views/calls_page/calls_page.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:flutter/material.dart';

class MainPageController extends Controller<MainPage> {
  MainPageController({Presenter<MainPage, MainPageController> presenter}) {
    this.presenter = presenter;
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int currentPage = 0;

  final List<Widget> bodyWidget = [
    CargoPage(key: GlobalKey()),
    VehiclePage(key: GlobalKey()),
    ProfilePage(key: GlobalKey())
  ];

  void bottomNavigationItemSelected(BuildContext context, int index) {
    presenter.update(() {
      currentPage = index;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  Widget getBody() {
    return Stack(
      children: bodyWidget.map((body) {
        int index = bodyWidget.indexOf(body);
        return Offstage(child: body, offstage: index != currentPage);
      }).toList(),
    );
  }
}
