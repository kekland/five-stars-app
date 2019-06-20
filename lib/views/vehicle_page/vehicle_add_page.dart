import 'package:five_stars/api/cargo.dart';
import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/design/boolean_select_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/number_select_widget.dart';
import 'package:five_stars/design/select_city_widget.dart';
import 'package:five_stars/design/select_time_widget.dart';
import 'package:five_stars/design/select_vehicle_type.dart';
import 'package:five_stars/design/string_select_widget.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/models/properties.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/cargo_page/cargo_expanded_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:five_stars/views/vehicle_page/vehicle_expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleAddPage extends StatefulWidget {
  @override
  _VehicleAddPageState createState() => _VehicleAddPageState();
}

class _VehicleAddPageState extends State<VehicleAddPage> {
  City departure;
  City arrival;
  DateTime departureTime;
  Properties properties;
  Dimensions dimensions;
  VehicleInformation information;

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
    information = VehicleInformation(
        model: null, description: null, vehicleType: null);

    setState(() {});
  }

  void addVehicle(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.red);
      final data = await VehicleApi.addVehicle(
        context: context,
        arrival: arrival,
        departure: departure,
        departureTime: departureTime,
        dimensions: Dimensions(
          width: dimensions.width / 100.0,
          height: dimensions.height / 100.0,
          length: dimensions.length / 100.0,
        ),
        information: information,
        properties: Properties(
          volume: properties.volume / 1000000.0,
          weight: properties.weight,
        ),
      );
      Navigator.of(context).pop();

      await Navigator.of(context).push(
        TransparentRoute(
          builder: (context) {
            return VehicleExpandedWidget(
              data: data,
              heroPrefix: '',
            );
          },
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      showErrorSnackbar(
          context: context,
          errorMessage: 'Произошла ошибка при добавлении транспорта.',
          exception: e);
    }
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
              StringSelectWidget(
                icon: FontAwesomeIcons.truck,
                title: 'Марка машины',
                value: information.model,
                onSelected: (value) =>
                    setState(() => information.model = value),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          onTap: (isValid()) ? () => addVehicle(context) : null,
          body: SingleLineInformationWidget(
            icon: Icons.check,
            label: 'Добавить груз',
            color: (isValid()) ? Colors.green : Colors.grey,
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