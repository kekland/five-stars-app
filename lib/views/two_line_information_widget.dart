import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class TwoLineInformationWidget extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final bool showIcon;
  final String title;
  final String value;
  final String unit;

  const TwoLineInformationWidget(
      {Key key, this.title, this.value, this.unit, this.icon, this.iconColor, this.showIcon = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        (showIcon)
            ? Icon(
                icon,
                color: iconColor,
              )
            : SizedBox(
                width: 24.0,
                height: 24.0,
              ),
        SizedBox(width: 12.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: ModernTextTheme.primaryAccented,
                ),
                Text(
                  unit,
                  style: ModernTextTheme.secondary,
                ),
              ],
            ),
            Text(
              title,
              style: ModernTextTheme.caption,
            ),
          ],
        ),
      ],
    );
  }
}
