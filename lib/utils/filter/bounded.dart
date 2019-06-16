
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

class Bounded {
  double lower;
  double upper;

  Bounded({this.lower, this.upper});

  update(double newLowerBound, double newUpperBound) {
    lower = newLowerBound;
    upper = newUpperBound;
  }

  bool isInRange(double number) {
    if(lower <= number && number <= upper) return true;
    return false;
  }
  @override
  String toString() {
    return "${lower.round().toString()} - ${upper.round().toString()}";
  }

  Map toJson() => {
    "lower": lower,
    "upper": upper,
  };
}
