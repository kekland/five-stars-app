import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectTimeWidget extends StatelessWidget {
  final Function(DateTime) onSelected;
  final DateTime selectedTime;
  final String subtitle;
  final IconData icon;

  void onClick(BuildContext context) async {
    DateTime date = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2030));
    
    if(date == null) {
      date = selectedTime;
    }
    onSelected(date);
  }

  const SelectTimeWidget({Key key, this.onSelected, this.selectedTime, this.subtitle, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onClick(context),
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TwoLineInformationWidgetExpanded(
            title: subtitle,
            value: dateTimeToString(selectedTime),
            iconColor: ModernTextTheme.captionIconColor,
            icon: icon,
            unit: "",
          ),
        ),
      ),
    );
  }
}
