import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoolSelectWidget extends StatelessWidget {
  final bool value;
  final bool padLeft;
  final Function(bool) onSelected;
  final String title;
  final Color color;

  const BoolSelectWidget({
    Key key,
    this.value,
    this.onSelected,
    this.title, this.color = Colors.red, this.padLeft = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onSelected(!value),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: (padLeft)? const EdgeInsets.all(16.0) : const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
          child: SingleLineInformationWidget(
            icon: (value) ? Icons.check_box : Icons.check_box_outline_blank,
            label: title,
            color: color,
          ),
        ),
      ),
    );
  }
}
