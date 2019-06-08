import 'package:dio/dio.dart';
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

void showModernDialog(
    {BuildContext context,
    String title,
    String text,
    Widget body,
    List<Widget> actions}) {
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

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: FutureDialog(
          data: DialogData(
              title: title, subtitle: text, customBody: body, actions: actions),
        ),
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

void showErrorSnackbar(
    {@required BuildContext context,
    @required String errorMessage,
    Object exception,
    bool showDialog = true}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 3),
      action: (showDialog)
          ? SnackBarAction(
              label: "Подробнее",
              onPressed: () {
                showModernDialog(
                  text: (exception is DioError)
                      ? "${exception?.message} ${exception.response?.data}"
                      : exception.toString(),
                  title: 'Ошибка',
                  context: context,
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Закрыть'),
                      onPressed: () => Navigator.of(context).pop(),
                      textColor: Colors.blue,
                    ),
                  ],
                );
              },
            )
          : null,
      behavior: SnackBarBehavior.floating,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
  );
}

void showInfoSnackbar({
  @required BuildContext context,
  @required String message,
}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "Хорошо",
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
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

enum AlterMode {
  add,
  edit
}