import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/properties.dart';
import 'package:five_stars/models/route_model.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PropertiesWidget extends StatelessWidget {
  final Properties data;
  final DirectionRoute route;

  const PropertiesWidget({Key key, this.data, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.cube,
          title: 'Объём (см³)',
          value: (data.volume * 1000000.0).round().toString(),
          unit: "см³",
        ),
        SizedBox(height: 16.0),
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.weightHanging,
          title: 'Вес (кг)',
          value: data.weight.round().toString(),
          unit: "кг.",
        ),
        SizedBox(height: 16.0),
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.route,
          title: 'Дистанция',
          value: route != null
              ? (route.distance / 1000.0).toStringAsFixed(1).toString()
              : 'Неизвестно',
          unit: route != null ? "км." : '',
        ),
      ],
    );
  }
}
