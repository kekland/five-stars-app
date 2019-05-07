import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/intro_page/intro_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    setStatusBar(Brightness.dark);

    return MaterialApp(
      title: 'Пять Звёзд',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      routes: {
        "/": (context) => IntroPage(),
        "/main": (context) => MainPage(),
      },
      initialRoute: "/",
    );
  }
}
