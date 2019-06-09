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

  final Color departureColor;
  final Color arrivalColor;

  final bool isCargo;

  const DepartureArrivalWidget(
      {Key key,
      this.departureCity,
      this.departureDate,
      this.arrivalCity,
      this.arrivalDate,
      this.isCargo,
      this.departureColor = Colors.black,
      this.arrivalColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon((isCargo) ? FontAwesomeIcons.dolly : FontAwesomeIcons.truck,
              size: 20.0, color: ModernTextTheme.captionColor.withOpacity(0.1)),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (departureDate != null)
                  Text(
                    dateTimeToString(departureDate.toLocal()),
                    style: ModernTextTheme.caption,
                  ),
                Text(
                  departureCity.name,
                  style: ModernTextTheme.primaryAccented
                      .copyWith(color: departureColor),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.0),
          Align(
            alignment: Alignment.center,
            child: Icon(
              FontAwesomeIcons.arrowRight,
              color: ModernTextTheme.captionColor.withOpacity(0.1),
              size: 14.0,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (arrivalDate != null)
                  Text(
                    dateTimeToString(arrivalDate.toLocal()),
                    style: ModernTextTheme.caption,
                  ),
                Text(
                  arrivalCity.name,
                  textAlign: TextAlign.right,
                  style: ModernTextTheme.primaryAccented
                      .copyWith(color: arrivalColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
