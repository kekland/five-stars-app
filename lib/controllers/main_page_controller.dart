import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/cargo_page/cargo_add_page.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/cargo_page/cargo_search.dart';
import 'package:five_stars/views/cargo_page/cargo_user_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/settings_page/settings_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_add_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_search.dart';
import 'package:five_stars/views/vehicle_page/vehicle_user_page.dart';
import 'package:flutter/material.dart';

class MainPageController extends Controller<MainPage> {
  MainPageController({Presenter<MainPage, MainPageController> presenter}) {
    this.presenter = presenter;
  }

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int currentPage = 0;

  final List<Widget> bodyWidget = [
    CargoSearch(),
    (AppData.username == null)? Container() : CargoAddPage(),
    (AppData.username == null)? Container() : CargoUserPage(favorites: true, username: AppData.username),
    (AppData.username == null)? Container() : CargoUserPage(favorites: false, username: AppData.username),
    VehicleSearch(),
    (AppData.username == null)? Container() : VehicleAddPage(),
    (AppData.username == null)? Container() : VehicleUserPage(favorites: true, username: AppData.username),
    (AppData.username == null)? Container() : VehicleUserPage(favorites: false, username: AppData.username),
    Container(color: Colors.amber),
    SettingsPage(),
    (AppData.username == null)? Container() : ProfilePage(username: AppData.username),
  ];
  
  final List<String> titles = [
    'Поиск груза',
    'Добавление груза',
    'Избранные грузы',
    'Мои грузы',
    'Поиск транспорта',
    'Добавление транспорта',
    'Избранный транспорт',
    'Мой транспорт',
    'В разработке',
    'Настройки',
    'Мой профиль'
  ];

  void selectItem(BuildContext context, int index) {
    presenter.update(() {
      currentPage = index;
    });
    Navigator.pop(context);
  }

  void register(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  bool isItemSelected(int index) {
    return currentPage == index;
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
