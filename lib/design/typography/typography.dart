import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModernTextTheme {
  static TextStyle normal = TextStyle(
    fontFamily: "Inter",
    color: normalColor,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static TextStyle caption = normal.merge(
    TextStyle(
      color: captionColor,
    ),
  );

  static TextStyle primary = normal.merge(
    TextStyle(
      color: primaryColor,
      fontSize: 16.0,
    ),
  );
  
  static TextStyle primaryAccented = normal.merge(
    TextStyle(
      color: primaryColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextStyle secondary = normal.merge(
    TextStyle(
      color: secondaryColor,
      fontSize: 16.0,
    ),
  );
  static TextStyle title = normal.merge(
    TextStyle(
      color: primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
  );
  static TextStyle boldTitle = normal.merge(
    TextStyle(
      color: primaryColor,
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
    ),
  );

  static Color primaryColor = Colors.black;
  static Color normalColor = Colors.black.withOpacity(0.9);
  static Color secondaryColor = Colors.black.withOpacity(0.5);
  static Color captionColor = Colors.black.withOpacity(0.355);
}
