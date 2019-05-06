import 'package:flutter/material.dart';

class TwoLineInformationWidget extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String title;
  final String value;
  final String unit;

  const TwoLineInformationWidget({Key key, this.title, this.value, this.unit, this.icon, this.iconColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(width: 16.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  unit,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black.withOpacity(0.355),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
