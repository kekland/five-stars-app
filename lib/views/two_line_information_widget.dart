import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class TwoLineInformationWidget extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final bool showIcon;
  final String title;
  final String value;
  final String unit;
  final bool emptySpaceOnHideIcon;
  final VoidCallback onTap;

  const TwoLineInformationWidget({
    Key key,
    this.title,
    this.value,
    this.unit = '',
    this.icon,
    this.iconColor,
    this.showIcon = true,
    this.onTap,
    this.emptySpaceOnHideIcon = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (showIcon)
                ? Icon(
                    icon,
                    color: iconColor,
                  )
                : SizedBox(
                    width: (emptySpaceOnHideIcon) ? 0.0 : 24.0,
                    height: 24.0,
                  ),
            SizedBox(width: 12.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value,
                      softWrap: true,
                      maxLines: 2,
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
        ),
      ),
    );
  }
}

class TwoLineInformationWidgetExpanded extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final bool showIcon;
  final String title;
  final String value;
  final String unit;
  final VoidCallback onTap;

  const TwoLineInformationWidgetExpanded(
      {Key key,
      this.title,
      this.value,
      this.unit = '',
      this.icon,
      this.iconColor,
      this.showIcon = true,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
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
            SizedBox(width: 24.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value,
                        softWrap: true,
                        maxLines: 2,
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
            ),
          ],
        ),
      ),
    );
  }
}

class SingleLineInformationWidget extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String label;
  final Color color;

  const SingleLineInformationWidget(
      {Key key,
      this.icon,
      this.label,
      this.color = Colors.black,
      this.iconSize = 24.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: (color == Colors.black)
              ? color.withOpacity(0.125)
              : color.withOpacity(0.65),
          size: iconSize,
        ),
        SizedBox(width: 24.0),
        Text(label,
            style: ModernTextTheme.primaryAccented.copyWith(color: color)),
      ],
    );
  }
}

class SingleLineInformationWidgetInline extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String label;
  final Color color;

  const SingleLineInformationWidgetInline(
      {Key key,
      this.icon,
      this.label,
      this.color = Colors.black,
      this.iconSize = 24.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: (color == Colors.black)
              ? color.withOpacity(0.125)
              : color.withOpacity(0.65),
          size: iconSize,
        ),
        SizedBox(width: 12.0),
        Text(label,
            style: ModernTextTheme.primaryAccented.copyWith(color: color)),
      ],
    );
  }
}
