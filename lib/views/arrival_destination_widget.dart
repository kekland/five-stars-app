import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepartureArrivalWidget extends StatelessWidget {
  final City departureCity;
  final DateTime departureDate;

  final City arrivalCity;
  final DateTime arrivalDate;

  const DepartureArrivalWidget({Key key, this.departureCity, this.departureDate, this.arrivalCity, this.arrivalDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTimeToString(departureDate),
                  style: ModernTextTheme.caption,
                ),
                Text(
                  departureCity.name,
                  style: ModernTextTheme.primaryAccented,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              FontAwesomeIcons.arrowRight,
              color: ModernTextTheme.captionColor.withOpacity(0.125),
              size: 18.0,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateTimeToString(arrivalDate),
                  style: ModernTextTheme.caption,
                ),
                Text(
                  arrivalCity.name,
                  style: ModernTextTheme.primaryAccented,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
