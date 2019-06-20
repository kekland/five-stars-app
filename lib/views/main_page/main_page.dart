import 'package:five_stars/controllers/main_page_controller.dart';
import 'package:five_stars/design/bottom_navigation_bar.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
//import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      key: MainPageController.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(controller.titles[controller.currentPage],
            style: TextStyle(color: Colors.black)),
        elevation: 4.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: Theme(
          data: ThemeData(primaryColor: Colors.red),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: InkWell(
                  onTap: (AppData.username == null)
                      ? () => controller.register(context)
                      : () => controller.selectItem(context, 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 64.0,
                          height: 64.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppData.username != null
                                ? AppData.username[0]
                                : 'Г',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                        TwoLineInformationWidget(
                          showIcon: false,
                          title: (AppData.username == null)
                              ? 'Зарегистрироваться'
                              : 'Личный кабинет',
                          value: AppData.username ?? 'Гость',
                          emptySpaceOnHideIcon: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                child: Text('Грузы', style: ModernTextTheme.caption),
                padding: const EdgeInsets.all(16.0),
              ),
              ListTile(
                title: Text('Поиск грузов'),
                leading: Icon(FontAwesomeIcons.dolly, size: 20.0),
                onTap: () => controller.selectItem(context, 0),
                selected: controller.isItemSelected(0),
              ),
              ListTile(
                title: Text('Добавить груз'),
                leading: Icon(FontAwesomeIcons.plus, size: 20.0),
                onTap: (AppData.username == null)
                    ? null
                    : () => controller.selectItem(context, 1),
                selected: controller.isItemSelected(1),
                enabled: (AppData.username != null),
              ),
              ListTile(
                title: Text('Избранные грузы'),
                leading: Icon(FontAwesomeIcons.solidStar, size: 20.0),
                onTap: (AppData.username == null)
                    ? null
                    : () => controller.selectItem(context, 2),
                selected: controller.isItemSelected(2),
                enabled: (AppData.username != null),
              ),
              ListTile(
                title: Text('Мои грузы'),
                leading: Icon(FontAwesomeIcons.boxes, size: 20.0),
                onTap: (AppData.username == null)
                    ? null
                    : () => controller.selectItem(context, 3),
                selected: controller.isItemSelected(3),
                enabled: (AppData.username != null),
              ),
              DividerWidget(),
              Padding(
                child: Text('Транспорт', style: ModernTextTheme.caption),
                padding: const EdgeInsets.all(16.0),
              ),
              ListTile(
                title: Text('Поиск транспорта'),
                leading: Icon(FontAwesomeIcons.truck, size: 20.0),
                onTap: () => controller.selectItem(context, 4),
                selected: controller.isItemSelected(4),
              ),
              ListTile(
                title: Text('Добавить транспорт'),
                leading: Icon(FontAwesomeIcons.plus, size: 20.0),
                onTap: (AppData.username == null)
                    ? null
                    : () => controller.selectItem(context, 5),
                selected: controller.isItemSelected(5),
                enabled: (AppData.username != null),
              ),
              ListTile(
                title: Text('Избранный транспорт'),
                leading: Icon(FontAwesomeIcons.solidStar, size: 20.0),
                onTap: (AppData.username == null)
                    ? null
                    : () => controller.selectItem(context, 6),
                selected: controller.isItemSelected(6),
                enabled: (AppData.username != null),
              ),
              ListTile(
                title: Text('Мой транспорт'),
                leading: Icon(FontAwesomeIcons.truckLoading, size: 20.0),
                onTap: (AppData.username == null)
                    ? null
                    : () => controller.selectItem(context, 7),
                selected: controller.isItemSelected(7),
                enabled: (AppData.username != null),
              ),
              DividerWidget(),
              ListTile(
                title: Text('Справка'),
                leading: Icon(FontAwesomeIcons.info, size: 20.0),
                onTap: () => controller.selectItem(context, 8),
                selected: controller.isItemSelected(8),
              ),
              ListTile(
                title: Text('Настройки'),
                leading: Icon(Icons.settings),
                onTap: () => controller.selectItem(context, 9),
                selected: controller.isItemSelected(9),
              ),
            ],
          ),
        ),
      ),
      body: controller.getBody(),
    );
  }
}
