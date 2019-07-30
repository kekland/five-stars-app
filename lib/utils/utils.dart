import 'package:dio/dio.dart';
import 'package:five_stars/controllers/main_page_controller.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/future_dialog.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location_permissions/location_permissions.dart';
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

Future<T> showModernDialog<T>(
    {BuildContext context,
    String title,
    String text,
    Widget body,
    List<Widget> actions}) async {
  T value = await showDialog<T>(
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
  return value;
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
    ),
  );
}

void showErrorSnackbarKeyed(
    {@required GlobalKey<ScaffoldState> key,
    @required String errorMessage,
    Object exception,
    bool showDialog = true}) {
  key.currentState.showSnackBar(
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
                  context: key.currentContext,
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Закрыть'),
                      onPressed: () => Navigator.of(key.currentContext).pop(),
                      textColor: Colors.blue,
                    ),
                  ],
                );
              },
            )
          : null,
    ),
  );
}

void showErrorSnackbarMain(
    {
    @required String errorMessage,
    Object exception,
    bool showDialog = true}) {
  MainPageController.scaffoldKey.currentState.showSnackBar(
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
                  context: MainPageController.scaffoldKey.currentContext,
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Закрыть'),
                      onPressed: () => Navigator.of(MainPageController.scaffoldKey.currentContext).pop(),
                      textColor: Colors.blue,
                    ),
                  ],
                );
              },
            )
          : null,
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
    ),
  );
}

void showInfoSnackbarMain({
  @required String message,
}) {
  MainPageController.scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "Хорошо",
        onPressed: () {},
      ),
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

Future<PermissionStatus> checkForLocationPermission() async {
  PermissionStatus permissionBefore = await LocationPermissions().checkPermissionStatus();
  if(permissionBefore != PermissionStatus.granted) {
    return await LocationPermissions().requestPermissions();
  }
  return PermissionStatus.granted;
}

List<LatLng> decodePolyline(String encoded) {
  List<LatLng> points = new List<LatLng>();
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;
  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;
    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;
    LatLng p = new LatLng(lat / 1E5, lng / 1E5);
    points.add(p);
  }
  return points;
}

enum AlterMode { add, edit }
