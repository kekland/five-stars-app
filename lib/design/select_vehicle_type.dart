import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectVehicleType extends StatelessWidget {
  VehicleType selectedVehicleType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TwoLineInformationWidgetExpanded(
            iconColor: ModernTextTheme.captionIconColor,
            icon: FontAwesomeIcons.truckMoving,
            title: 'Тип кузова',
            value: VehicleTypeUtils.vehicleTypeNames[selectedVehicleType],
            unit: "",
          ),
        ),
      ),
    );
  }
}
