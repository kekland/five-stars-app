import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Shadows {
  static BoxShadow slightShadow = BoxShadow(
    color: Colors.black.withOpacity(0.075),
    offset: Offset(0.0, 2.0),
    blurRadius: 2.0,
  );
  static BoxShadow slightShadowTop = BoxShadow(
    color: Colors.black.withOpacity(0.095),
    offset: Offset(0.0, -2.0),
    blurRadius: 4.0,
  );
}
