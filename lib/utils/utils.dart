import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
