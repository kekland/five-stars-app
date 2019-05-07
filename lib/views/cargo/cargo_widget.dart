import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/arrival_destination_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoWidget extends StatelessWidget {
  final Cargo data;

  const CargoWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(16.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DepartureArrivalWidget(
            arrivalCity: data.arrivalCity,
            arrivalDate: data.arrivalDate,
            departureCity: data.departureCity,
            departureDate: data.departureDate,
          ),
          DividerWidget(),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              runSpacing: 16.0,
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                TwoLineInformationWidget(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.box,
                  title: 'Объем (м³)',
                  value: data.volume.cubicMeter.round().toString(),
                  unit: "м³",
                ),
                TwoLineInformationWidget(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.weightHanging,
                  title: 'Вес (тонн)',
                  value: data.weight.ton.round().toString(),
                  unit: "т.",
                ),
                TwoLineInformationWidget(
                  iconColor: Colors.green,
                  icon: FontAwesomeIcons.dollarSign,
                  title: 'Цена',
                  value: data.shipmentCost.truncate().toString(),
                  unit: "тг.",
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        FlatButton.icon(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.all(16.0),
          icon: Icon(Icons.chevron_right),
          label: Text('Подробнее'),
          onPressed: () {},
        ),
      ],
    );
  }
}
