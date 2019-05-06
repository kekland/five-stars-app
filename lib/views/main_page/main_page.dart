import 'package:five_stars/controllers/main_page_controller.dart';
import 'package:five_stars/design/bottom_navigation_bar.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
//import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends Presenter<MainPage, MainPageController> {
  int index = 0;
  @override
  void initController() {
    controller = MainPageController(presenter: this);
  }

  @override
  Widget present(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      //body: Container(),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: Icons.inbox,
            title: 'Груз',
            color: Colors.pink,
          ),
          TabData(
            iconData: Icons.local_shipping,
            title: 'Транспорт',
            color: Colors.purple,
          ),
          TabData(
            iconData: Icons.call,
            title: 'Звонки',
            color: Colors.deepPurple,
          ),
          TabData(
            iconData: Icons.person,
            title: 'Личный кабинет',
            color: Colors.indigo,
          ),
        ],
        //fixedColor: Colors.white,
        initialSelection: controller.currentPage,
        onTabChangedListener: (index) => controller.bottomNavigationItemSelected(context, index),
        textColor: Colors.blue,
        inactiveIconColor: Colors.black26,
      ),
      body: controller.getBody(),
    );
  }
}
