import 'package:five_stars/design/shadows/shadows.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class StadiumSwitchWidget extends StatelessWidget {
  final String title;
  final bool checked;
  final VoidCallback onToggle;
  final Color color;
  final Color backgroundColor;

  const StadiumSwitchWidget({
    Key key,
    @required this.title,
    @required this.checked,
    @required this.color,
    @required this.backgroundColor,
    @required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 125),
      decoration: BoxDecoration(
        color: (checked)? color : backgroundColor,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [Shadows.slightShadow],
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(24.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(24.0),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: ModernTextTheme.primary.copyWith(
                color: (checked) ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
