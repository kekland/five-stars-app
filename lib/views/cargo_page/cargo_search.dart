import 'package:five_stars/api/cargo.dart';
import 'package:five_stars/design/bounded_number_select_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/select_city_widget.dart';
import 'package:five_stars/design/select_location_page.dart';
import 'package:five_stars/design/select_time_widget.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoSearch extends StatefulWidget {
  @override
  _CargoSearchState createState() => _CargoSearchState();
}

class _CargoSearchState extends State<CargoSearch> {
  City departure;
  City arrival;
  DateTime departureTime;
  DateTime now;
  Bounded weight;
  Bounded volume;
  Bounded price;
  Bounded distance;

  Bounded width;
  Bounded length;
  Bounded height;

  @override
  void initState() {
    now = DateTime.now().toUtc();
    now = now.subtract(
      Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
      ),
    );
    departureTime = now.add(Duration(days: 1));
    super.initState();
  }

  void getCargo(BuildContext context) async {
    final data = await CargoApi.getCargo(
      context: context,
      arrival: arrival,
      departure: departure,
      departureDate: departureTime,
      distance: distance,
      height: height,
      length: length,
      price: price,
      volume: volume,
      weight: weight,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      physics: BouncingScrollPhysics(),
      children: [
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          onTap: () => getCargo(context),
          body: SingleLineInformationWidget(
            icon: Icons.search,
            color: Colors.green,
            label: 'Найти грузы',
          ),
        ),
        SizedBox(height: 24.0),
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
              BoundedNumberSelectWidget(
                icon: FontAwesomeIcons.weightHanging,
                title: 'Вес',
                unit: 'кг.',
                value: weight,
                onSelected: (value) => setState(() => weight = value),
              ),
              BoundedNumberSelectWidget(
                icon: FontAwesomeIcons.cube,
                title: 'Объём',
                unit: 'м³',
                value: volume,
                onSelected: (value) => setState(() => volume = value),
              ),
              BoundedNumberSelectWidget(
                icon: FontAwesomeIcons.dollarSign,
                title: 'Цена',
                unit: 'тг.',
                value: price,
                onSelected: (value) => setState(() => price = value),
              ),
              BoundedNumberSelectWidget(
                icon: FontAwesomeIcons.route,
                title: 'Дистанция',
                unit: 'км.',
                value: distance,
                onSelected: (value) => setState(() => distance = value),
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
              BoundedNumberSelectWidget(
                icon: FontAwesomeIcons.rulerHorizontal,
                title: 'Длина',
                unit: 'см.',
                value: length,
                onSelected: (value) => setState(() => length = value),
              ),
              BoundedNumberSelectWidget(
                icon: FontAwesomeIcons.rulerCombined,
                title: 'Ширина',
                unit: 'см.',
                value: width,
                onSelected: (value) => setState(() => width = value),
              ),
              BoundedNumberSelectWidget(
                icon: FontAwesomeIcons.rulerVertical,
                title: 'Высота',
                unit: 'см.',
                value: height,
                onSelected: (value) => setState(() => height = value),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          body: SingleLineInformationWidget(
            icon: Icons.save,
            label: 'Сохранить фильтр',
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
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
