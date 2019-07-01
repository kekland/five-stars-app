
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

class Bounded<T> {
  T lower;
  T upper;

  Bounded({this.lower, this.upper});

  @override
  String toString() {
    return "${lower.toString()} - ${upper.toString()}";
  }

  Bounded.fromJson(Map json) {
    this.lower = json['lower'];
    this.upper = json['upper'];
  }

  Map toJson() => {
    "lower": lower,
    "upper": upper,
  };
}
