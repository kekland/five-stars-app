import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as RangePicker;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectTimeWidget extends StatelessWidget {
  final Function(DateTime) onSelected;
  final DateTime selectedTime;
  final String subtitle;
  final IconData icon;

  final bool Function(DateTime) predicate;

  void onClick(BuildContext context) async {
    DateTime date = await showDatePicker(
      selectableDayPredicate: predicate,
      context: context,
      initialDate: selectedTime,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (date == null) {
      date = selectedTime;
    }
    onSelected(date);
  }

  const SelectTimeWidget(
      {Key key,
      this.onSelected,
      this.selectedTime,
      this.subtitle,
      this.icon,
      this.predicate})
      : super(key: key);
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

class SelectTimeRangeWidget extends StatelessWidget {
  final Function(Bounded<DateTime>) onSelected;
  final Bounded<DateTime> selectedTime;
  final String subtitle;
  final IconData icon;

  final bool Function(DateTime) predicate;

  void onClick(BuildContext context) async {
    List<DateTime> date = await RangePicker.showDatePicker(
      initialFirstDate: selectedTime.lower,
      initialLastDate: selectedTime.upper,
      selectableDayPredicate: predicate,
      context: context,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      onSelected(Bounded(lower: date.first, upper: date.last));
    }
  }

  const SelectTimeRangeWidget(
      {Key key,
      this.onSelected,
      this.selectedTime,
      this.subtitle,
      this.icon,
      this.predicate})
      : super(key: key);
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
            value: '${dateTimeToString(selectedTime.lower)} - ${dateTimeToString(selectedTime.upper)}',
            iconColor: ModernTextTheme.captionIconColor,
            icon: icon,
            unit: "",
          ),
        ),
      ),
    );
  }
}
