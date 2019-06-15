import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/cargo_page/cargo_search.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:flutter/material.dart';

class MainPageController extends Controller<MainPage> {
  MainPageController({Presenter<MainPage, MainPageController> presenter}) {
    this.presenter = presenter;
  }

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int currentPage = 0;

  final List<Widget> bodyWidget = [
    CargoSearch(),
    Container(color: Colors.orange),
    Container(color: Colors.yellow),
    Container(color: Colors.green),
    Container(color: Colors.teal),
    Container(color: Colors.blue),
    Container(color: Colors.purple),
    Container(color: Colors.black),
    Container(color: Colors.amber),
    Container(color: Colors.pink),
  ];

  void selectItem(BuildContext context, int index) {
    presenter.update(() {
      currentPage = index;
    });
    Navigator.pop(context);
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
