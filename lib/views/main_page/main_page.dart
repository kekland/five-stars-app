import 'package:five_stars/controllers/main_page_controller.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/pages.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends Presenter<MainPage, MainPageController> {
  @override
  void initController() {
    controller = MainPageController(presenter: this);
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '${AppData.getName()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Свободный груз'),
            leading: Icon(Icons.inbox),
            selected: (controller.currentPage == Page.Cargo),
            onTap: () => controller.selectPage(context, Page.Cargo),
          ),
          ListTile(
            title: Text('Свободный транспорт'),
            leading: Icon(Icons.local_shipping),
            selected: (controller.currentPage == Page.Vehicle),
            onTap: () => controller.selectPage(context, Page.Vehicle),
          ),
          ListTile(
            title: Text('Звонок диспетчеру'),
            leading: Icon(Icons.call),
          ),
          ListTile(
            title: Text('Запрос звонка'),
            leading: Icon(Icons.call_received),
          ),
          ListTile(
            title: Text('Настройки'),
            leading: Icon(Icons.settings),
            selected: (controller.currentPage == Page.Settings),
            onTap: () => controller.selectPage(context, Page.Settings),
          ),
          ListTile(
            title: Text('Выход'),
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }

  Widget buildFAB() {
    return (controller.currentPage == Page.Vehicle || controller.currentPage == Page.Cargo)
        ? FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text('Добавить ' + ((controller.currentPage == Page.Vehicle) ? 'транспорт' : 'груз')),
            onPressed: () {},
          )
        : null;
  }

  @override
  Widget present(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(controller.getTitle()),
      ),
      drawer: buildDrawer(),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: controller.openDrawer,
              ),
              IconButton(
                icon: Icon(Icons.account_box),
                onPressed: () => controller.selectPage(context, Page.MyProfile),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
