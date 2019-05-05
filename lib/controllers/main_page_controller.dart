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
  Page currentPage = Page.Cargo;

  Map<Page, Widget> bodyWidget = {
    Page.Cargo: CargoPage(key: GlobalKey()),
    Page.Vehicle: Container(color: Colors.red),
    Page.MyProfile: Container(color: Colors.green),
    Page.Settings: Container(color: Colors.yellow)
  };

  void selectPage(BuildContext context, Page page) {
    if(scaffoldKey.currentState.isDrawerOpen) {
      Navigator.of(context).pop();
    }

    presenter.update(() {
      currentPage = page;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  Widget getBody() {
    return bodyWidget[currentPage];
  }

  String getTitle() {
    switch(currentPage) {
      case Page.Cargo: return 'Свободный груз';
      case Page.Vehicle: return 'Свободный транспорт';
      case Page.MyProfile: return 'Личный кабинет';
      case Page.Settings: return 'Настройки';
      default: return 'Пять звёзд';
    }
  }
}