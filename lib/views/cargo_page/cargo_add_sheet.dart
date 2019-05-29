import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/select_city_widget.dart';
import 'package:five_stars/design/select_time_widget.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoAddPage extends StatefulWidget {
  @override
  _CargoAddPageState createState() => _CargoAddPageState();
}

class _CargoAddPageState extends State<CargoAddPage> {
  DateTime departureTime = DateTime.now();
  DateTime arrivalTime = DateTime.now();

  Widget buildDepartureWidget(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(8.0),
      body: Column(
        children: [
          SelectCityWidget(
            icon: FontAwesomeIcons.truckLoading,
            subtitle: 'Город погрузки',
          ),
          SizedBox(height: 8.0),
          SelectTimeWidget(
            icon: FontAwesomeIcons.calendarAlt,
            subtitle: 'Дата погрузки',
            onSelected: (DateTime time) => setState(() => departureTime = time),
            selectedTime: departureTime,
          ),
        ],
      ),
    );
  }

  Widget buildArrivalWidget(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(8.0),
      body: Column(
        children: [
          SelectCityWidget(
            icon: FontAwesomeIcons.dolly,
            subtitle: 'Город выгрузки',
          ),
          SizedBox(height: 8.0),
          SelectTimeWidget(
            icon: FontAwesomeIcons.calendarAlt,
            subtitle: 'Дата выгрузки',
            onSelected: (DateTime time) => setState(() => arrivalTime = time),
            selectedTime: arrivalTime,
          ),
        ],
      ),
    );
  }

  Widget buildInfoWidget(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(24.0),
      body: Column(
        children: [
          ModernTextField(
            icon: FontAwesomeIcons.weightHanging,
            hintText: "Вес",
            keyboardType: TextInputType.number,
            suffixText: "кг.",
          ),
          SizedBox(height: 16.0),
          ModernTextField(
            icon: FontAwesomeIcons.box,
            hintText: "Объём",
            keyboardType: TextInputType.number,
            suffixText: "м3.",
          ),
          SizedBox(height: 16.0),
          ModernTextField(
            icon: FontAwesomeIcons.box,
            hintText: "Цена",
            keyboardType: TextInputType.number,
            suffixText: "тг.",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.0, left: 18.0, right: 18.0, bottom: 36.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CardWidget(
              padding: const EdgeInsets.all(24.0),
              body: Text('Добавить груз', style: ModernTextTheme.boldTitle),
            ),
            SizedBox(height: 16.0),
            buildDepartureWidget(context),
            SizedBox(height: 16.0),
            buildArrivalWidget(context),
            SizedBox(height: 16.0),
            buildInfoWidget(context),
          ],
        ),
      ),
    );
  }
}
