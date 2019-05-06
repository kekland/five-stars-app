import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:flutter/material.dart';

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
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                Text(
                  departureCity.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.chevron_right,
              color: Colors.black.withOpacity(0.135),
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
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                Text(
                  arrivalCity.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
