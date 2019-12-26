import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/design/bounded_number_select_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/select_city_widget.dart';
import 'package:five_stars/design/select_time_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleSearch extends StatefulWidget {
  @override
  _VehicleSearchState createState() => _VehicleSearchState();
}

class _VehicleSearchState extends State<VehicleSearch> {
  City departure;
  City arrival;
  Bounded<DateTime> departureTimes;
  DateTime now;
  Bounded<double> weight;
  Bounded<double> volume;
  Bounded<double> distance;

  Bounded<double> width;
  Bounded<double> length;
  Bounded<double> height;

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
    departureTimes = Bounded(lower: now, upper: now.add(Duration(days: 30)));
    super.initState();
  }

  void getVehicle(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: ModernColorTheme.main);
      final data = await VehicleApi.getVehicles(
        context: context,
        arrival: arrival,
        departure: departure,
        departureTimes: departureTimes,
        distance: distance,
        height: height,
        length: length,
        volume: volume != null
            ? Bounded(
                upper: volume.upper / 1000000.0,
                lower: volume.lower / 1000000.0)
            : null,
        weight: weight,
        width: width,
        showArchived: false,
        removeOld: true,
      );
      Navigator.of(context).popUntil((r) => r.isFirst);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => VehiclePage(vehicle: data),
        ),
      );
    } catch (e) {
      Navigator.of(context).popUntil((r) => r.isFirst);
      showErrorSnackbar(
          context: context,
          errorMessage: 'Произошла ошибка при поиске транспорта.',
          exception: e);
    }
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
              SelectTimeRangeWidget(
                icon: FontAwesomeIcons.solidClock,
                subtitle: 'Даты погрузки',
                predicate: (value) => now.isBefore(value),
                selectedTime: departureTimes,
                onSelected: (value) => setState(() => departureTimes = value),
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
                unit: 'см³',
                value: volume,
                onSelected: (value) => setState(() => volume = value),
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
          onTap: () => getVehicle(context),
          body: SingleLineInformationWidget(
            icon: Icons.search,
            color: Colors.green,
            label: 'Найти транспорт',
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          body: SingleLineInformationWidget(
            icon: Icons.delete,
            label: 'Очистить',
            color: ModernColorTheme.main,
          ),
        ),
      ],
    );
  }
}
