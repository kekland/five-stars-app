import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:five_stars/views/cargo/cargo_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:flutter/material.dart';

class MainPageController extends Controller<MainPage> {
  MainPageController({Presenter<MainPage, MainPageController> presenter}) {
    this.presenter = presenter;
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int currentPage = 0;

  Map<int, Widget> bodyWidget = {
    0: CargoPage(key: GlobalKey()),
    1: Container(color: Colors.red),
    2: Container(color: Colors.green),
    3: Container(color: Colors.yellow)
  };

  void bottomNavigationItemSelected(BuildContext context, int index) {
    presenter.update(() {
      currentPage = index;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  Widget getBody() {
    return bodyWidget[currentPage];
  }
}
