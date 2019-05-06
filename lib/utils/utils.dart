import 'package:intl/intl.dart';

var formatter = DateFormat("dd.MM.yyyy");
String dateTimeToString(DateTime dateTime) {
  return formatter.format(dateTime);
}