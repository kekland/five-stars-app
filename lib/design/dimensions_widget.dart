import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DimensionsWidget extends StatelessWidget {
  final Dimensions data;

  const DimensionsWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.rulerHorizontal,
          title: 'Длина',
          value: (data.length * 100.0).toString(),
          unit: 'см.',
        ),
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.rulerCombined,
          title: 'Ширина',
          value: (data.width * 100.0).toString(),
          unit: 'см.',
        ),
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.rulerVertical,
          title: 'Высота',
          value: (data.height * 100.0).toString(),
          unit: 'см.',
        ),
      ],
    );
  }
}
