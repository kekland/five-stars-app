import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleInformationWidget extends StatelessWidget {
  final VehicleInformation data;

  const VehicleInformationWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.envelopeOpenText,
          title: 'Информация',
          value: data.description ?? 'Нет информации',
        ),
        SizedBox(height: 16.0),
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.truckMoving,
          title: 'Тип кузова',
          value: VehicleTypeUtils.vehicleTypeNames[data.vehicleType],
        ),
        SizedBox(height: 16.0),
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.truck,
          title: 'Модель машины',
          value: data.model,
        ),
      ],
    );
  }
}
