import 'package:five_stars/views/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  void setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar();

    return MaterialApp(
      title: 'Пять Звёзд',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage()
    );
  }
}
