
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

  @override
  String toString() {
    return "${lower.round().toString()} - ${upper.round().toString()}";
  }
}

class BoundedRangeWidget extends StatelessWidget {
  final double minimumBound;
  final double maximumBound;
  final int divisions;
  final Bounded bounds;
  final Function(Bounded newBounds) onChange;
  final String title;
  final String unit;
  final IconData icon;
  final Color color;
  final Color colorLight;
  final Color colorDark;

  const BoundedRangeWidget({
    Key key,
    this.minimumBound = 0.0,
    @required this.maximumBound,
    this.divisions = 20,
    @required this.bounds,
    @required this.onChange,
    @required this.title,
    @required this.unit,
    @required this.icon,
    @required this.color,
    @required this.colorLight,
    @required this.colorDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TwoLineInformationWidget(
            iconColor: ModernTextTheme.captionIconColor,
            icon: icon,
            title: title,
            value: "$bounds",
            unit: unit,
          ),
        ),
        SliderTheme(
          data: SliderThemeData.fromPrimaryColors(
            primaryColor: color,
            primaryColorDark: colorDark,
            primaryColorLight: colorLight,
            valueIndicatorTextStyle: TextStyle(),
          ),
          child: RangeSlider(
            min: minimumBound,
            max: maximumBound,
            lowerValue: bounds.lower,
            upperValue: bounds.upper,
            divisions: 20,
            showValueIndicator: false,
            valueIndicatorMaxDecimals: 0,
            onChanged: (double newLowerBound, double newUpperBound) =>
                onChange(Bounded(lower: newLowerBound, upper: newUpperBound)),
          ),
        )
      ],
    );
  }
}