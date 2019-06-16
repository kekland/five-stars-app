import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoolSelectWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onSelected;
  final String title;

  const BoolSelectWidget({
    Key key,
    this.value,
    this.onSelected,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onSelected(!value),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleLineInformationWidget(
            icon: (value) ? Icons.check_box : Icons.check_box_outline_blank,
            label: title,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
