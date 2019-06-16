import 'package:flutter/material.dart';

class Dimensions {
  double width;
  double height;
  double length;

  Dimensions({this.width, this.height, this.length});

  Dimensions.fromJson(Map json) {
    width = (json['width'] as num).toDouble();
    height = (json['height'] as num).toDouble();
    length = (json['length'] as num).toDouble();
  }

  Map toJson() => {
    'width': width,
    'height': height,
    'length': length,
  };
  
  bool isValid() {
    return width != null && height != null && length != null;
  }
}