import 'dart:io';

import 'dart:io' show Platform;

import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/authorization_page/authorization_page.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:five_stars/views/intro_page/intro_page.dart';
import 'package:five_stars/views/main_page/main_page.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  _setTargetPlatformForDesktop();
  await SharedPreferencesManager.initialize();
  runApp(MyApp());
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isLinux || Platform.isWindows || Platform.isFuchsia) {
    targetPlatform = TargetPlatform.fuchsia;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    if (debugDefaultTargetPlatformOverride != TargetPlatform.fuchsia) {
      setStatusBar(Brightness.dark);
    }
    AppData.username = SharedPreferencesManager.instance.getString("username");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Пять звёзд',
      theme: ThemeData(
        primaryColor: ModernColorTheme.main,
        accentColor: ModernColorTheme.main,
        fontFamily: 'Inter',
      ),
      routes: {
        "/": (context) => IntroPage(),
        "/auth": (context) => AuthorizationPage(),
        "/main": (context) => MainPage(),
      },
      initialRoute: "/",
    );
  }
}
