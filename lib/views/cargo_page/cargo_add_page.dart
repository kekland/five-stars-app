import 'package:five_stars/design/boolean_select_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/number_select_widget.dart';
import 'package:five_stars/design/select_city_widget.dart';
import 'package:five_stars/design/select_time_widget.dart';
import 'package:five_stars/design/select_vehicle_type.dart';
import 'package:five_stars/design/string_select_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/models/properties.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoAddPage extends StatefulWidget {
  @override
  _CargoAddPageState createState() => _CargoAddPageState();
}

class _CargoAddPageState extends State<CargoAddPage> {
  City departure;
  City arrival;
  DateTime departureTime;
  Properties properties;
  Dimensions dimensions;
  CargoInformation information;

  DateTime now;

  bool isValid() {
    return departure != null &&
        arrival != null &&
        departureTime != null &&
        properties.isValid() &&
        dimensions.isValid() &&
        information.isValid();
  }

  void reset() {
    now = DateTime.now().toUtc();
    now = now.subtract(
      Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
      ),
    );
    departureTime = now.add(Duration(days: 1));

    departure = null;
    arrival = null;
    properties = Properties(volume: null, weight: null);
    dimensions = Dimensions(width: null, height: null, length: null);
    information = CargoInformation(
        dangerous: false, description: null, vehicleType: null);

    setState(() {});
  }

  void addCargo(BuildContext context) async {

  }

  @override
  void initState() {
    super.initState();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      physics: BouncingScrollPhysics(),
      children: [
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          body: Text(
            'Местоположение',
            style: ModernTextTheme.title,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          body: Column(
            children: <Widget>[
              SelectCityWidget(
                icon: FontAwesomeIcons.truckLoading,
                subtitle: 'Город погрузки',
                showGlobeIcon: true,
                selectedCity: departure,
                onSelected: (value) => setState(() => departure = value),
              ),
              SelectCityWidget(
                icon: FontAwesomeIcons.dolly,
                subtitle: 'Город выгрузки',
                showGlobeIcon: true,
                selectedCity: arrival,
                onSelected: (value) => setState(() => arrival = value),
              ),
              SelectTimeWidget(
                icon: FontAwesomeIcons.solidClock,
                subtitle: 'Дата погрузки',
                predicate: (value) => now.isBefore(value),
                selectedTime: departureTime,
                onSelected: (value) => setState(() => departureTime = value),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          body: Text(
            'Параметры',
            style: ModernTextTheme.title,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          body: Column(
            children: <Widget>[
              NumberSelectWidget(
                icon: FontAwesomeIcons.weightHanging,
                title: 'Вес',
                unit: 'кг.',
                value: properties.weight,
                onSelected: (value) =>
                    setState(() => properties.weight = value),
              ),
              NumberSelectWidget(
                icon: FontAwesomeIcons.cube,
                title: 'Объём',
                unit: 'см³',
                value: properties.volume,
                onSelected: (value) =>
                    setState(() => properties.volume = value),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          body: Text(
            'Размеры',
            style: ModernTextTheme.title,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          body: Column(
            children: <Widget>[
              NumberSelectWidget(
                icon: FontAwesomeIcons.rulerHorizontal,
                title: 'Длина',
                unit: 'см.',
                value: dimensions.length,
                onSelected: (value) =>
                    setState(() => dimensions.length = value),
              ),
              NumberSelectWidget(
                icon: FontAwesomeIcons.rulerCombined,
                title: 'Ширина',
                unit: 'см.',
                value: dimensions.width,
                onSelected: (value) => setState(() => dimensions.width = value),
              ),
              NumberSelectWidget(
                icon: FontAwesomeIcons.rulerVertical,
                title: 'Высота',
                unit: 'см.',
                value: dimensions.height,
                onSelected: (value) =>
                    setState(() => dimensions.height = value),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          body: Text(
            'Информация',
            style: ModernTextTheme.title,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          body: Column(
            children: <Widget>[
              StringSelectWidget(
                icon: FontAwesomeIcons.envelopeOpenText,
                title: 'Описание',
                value: information.description,
                onSelected: (value) =>
                    setState(() => information.description = value),
              ),
              SelectVehicleType(
                selectedVehicleType: information.vehicleType,
                onSelect: (value) =>
                    setState(() => information.vehicleType = value),
              ),
              BoolSelectWidget(
                title: 'Опасный груз',
                value: information.dangerous,
                onSelected: (value) =>
                    setState(() => information.dangerous = value),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          onTap: (isValid())? () => addCargo(context) : null,
          body: SingleLineInformationWidget(
            icon: Icons.check,
            label: 'Добавить груз',
            color: (isValid())? Colors.green : Colors.grey,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          onTap: reset,
          body: SingleLineInformationWidget(
            icon: Icons.delete,
            label: 'Очистить',
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
