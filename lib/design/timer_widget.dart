import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimerWidget extends StatelessWidget {
  final DateTime createdAt;
  final DateTime updatedAt;

  const TimerWidget({
    Key key,
    this.createdAt,
    this.updatedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoLineInformationWidgetExpanded(
          iconColor: ModernTextTheme.captionIconColor,
          icon: FontAwesomeIcons.clock,
          title: 'Создано',
          value: dateTimeToString(createdAt),
        ),
        if (createdAt.millisecondsSinceEpoch != updatedAt.millisecondsSinceEpoch) ...[
          SizedBox(height: 16.0),
          TwoLineInformationWidgetExpanded(
            iconColor: ModernTextTheme.captionIconColor,
            icon: FontAwesomeIcons.clock,
            title: 'Обновлено',
            value: dateTimeToString(updatedAt),
          ),
        ]
      ],
    );
  }
}
