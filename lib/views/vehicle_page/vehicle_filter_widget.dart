import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/stadium_switch_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class VehicleFilterOptions {
  Bounded volume;
  Bounded weight;
  List<VehicleType> allowedVehicleTypes;

  VehicleFilterOptions({this.volume, this.weight, this.allowedVehicleTypes});
}

class VehicleFilterWidget extends StatefulWidget {
  @override
  _VehicleFilterWidgetState createState() => _VehicleFilterWidgetState();
}

class _VehicleFilterWidgetState extends State<VehicleFilterWidget> {
  VehicleFilterOptions options = VehicleFilterOptions(
    volume: Bounded(lower: 0.0, upper: 1000.0),
    weight: Bounded(lower: 0.0, upper: 250.0),
    allowedVehicleTypes: List.from(VehicleType.values),
  );

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: EdgeInsets.zero,
      body: ExpandablePanel(
        header: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text('Фильтр', style: ModernTextTheme.primaryAccented),
        ),
        hasIcon: false,
        collapsed: SizedBox(),
        expanded: buildExpanded(),
        tapBodyToCollapse: false,
        tapHeaderToExpand: true,
      ),
    );
  }

  Widget buildExpanded() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8.0),
          BoundedRangeWidget(
            title: 'Объём (м³)',
            unit: 'м³',
            bounds: options.volume,
            onChange: (Bounded newBounds) => setState(() => options.volume = newBounds),
            maximumBound: 1000.0,
            divisions: 20,
            color: Colors.purple,
            colorLight: Colors.purple.shade300,
            colorDark: Colors.purple.shade600,
            icon: FontAwesomeIcons.cube,
          ),
          SizedBox(height: 24.0),
          BoundedRangeWidget(
            title: 'Вес (тонн)',
            unit: 'т.',
            bounds: options.weight,
            onChange: (Bounded newBounds) => setState(() => options.weight = newBounds),
            maximumBound: 250.0,
            divisions: 25,
            color: Colors.purple,
            colorLight: Colors.purple.shade300,
            colorDark: Colors.purple.shade600,
            icon: FontAwesomeIcons.weightHanging,
          ),
          DividerWidget(),
          Text('Тип кузова', style: ModernTextTheme.primaryAccented),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.start,
            children: vehicleTypeNames.keys
                .map((type) => StadiumSwitchWidget(
                      checked: (options.allowedVehicleTypes.contains(type)),
                      color: Colors.purple,
                      backgroundColor: Colors.purple.shade50,
                      title: vehicleTypeNames[type],
                      onToggle: () {
                        print(type.toString());
                        print(options.allowedVehicleTypes.contains(type));
                        if (options.allowedVehicleTypes.contains(type)) {
                          options.allowedVehicleTypes.remove(type);
                        } else {
                          options.allowedVehicleTypes.add(type);
                        }
                        setState(() {});
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
