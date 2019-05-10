import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/future_dialog.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var formatter = DateFormat("dd.MM.yyyy");
String dateTimeToString(DateTime dateTime) {
  if (dateTime == null) return "null";
  return formatter.format(dateTime);
}

void setStatusBar(Brightness iconBrightness) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: iconBrightness,
      statusBarColor: Colors.transparent,
    ),
  );
}

void showModernDialog({BuildContext context, String title, String text, List<Widget> actions}) {
  showDialog(
    context: context,
    builder: (_) {
      /*return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(title),
        content: Text(text),
        contentTextStyle: ModernTextTheme.secondary,
        actions: actions,
      );*/

      return FutureDialog(
        data: DialogData(title: title, subtitle: text, actions: actions),
      );
    },
  );
}

void showLoadingDialog({BuildContext context, Color color}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      /*return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(title),
        content: Text(text),
        contentTextStyle: ModernTextTheme.secondary,
        actions: actions,
      );*/

      return Center(child: CircularProgressRevealWidget(color: color));
    },
  );
}

class SharedPreferencesManager {
  static SharedPreferences instance;

  static Future initialize() async {
    try {
      instance = await SharedPreferences.getInstance();
    } catch (err) {
      print("could not initialize sharedprefs.");
    }
  }
}
