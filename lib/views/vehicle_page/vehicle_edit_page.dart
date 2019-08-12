import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/images_widget.dart';
import 'package:five_stars/design/number_select_widget.dart';
import 'package:five_stars/design/price_select_widget.dart';
import 'package:five_stars/design/select_city_widget.dart';
import 'package:five_stars/design/select_time_widget.dart';
import 'package:five_stars/design/select_vehicle_type.dart';
import 'package:five_stars/design/string_select_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/models/properties.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleEditPage extends StatefulWidget {
  final Vehicle data;

  final Function(Vehicle) onVehicleEdited;
  final BuildContext context;

  const VehicleEditPage(
      {Key key, this.data, this.onVehicleEdited, this.context})
      : super(key: key);
  @override
  _VehicleEditPageState createState() => _VehicleEditPageState();
}

class _VehicleEditPageState extends State<VehicleEditPage> {
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
    departureTime = widget.data.departureTime;
    departure = widget.data.departure;
    arrival = widget.data.arrival;
    properties = Properties(
      volume: widget.data.properties.volume * 1e6,
      weight: widget.data.properties.weight,
      price: widget.data.properties.price,
    );
    dimensions = Dimensions(
      width: widget.data.dimensions.width * 1e2,
      height: widget.data.dimensions.height * 1e2,
      length: widget.data.dimensions.length * 1e2,
    );
    information = widget.data.information;

    setState(() {});
  }

  void editVehicle(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.red);
      final data = await VehicleApi.editVehicle(
        context: context,
        id: widget.data.id,
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
          price: properties.price,
        ),
      );
      await Navigator.of(context).maybePop();
      await Navigator.of(context).maybePop();
      showInfoSnackbar(
          context: widget.context, message: 'Транспорт успешно изменён.');
      widget.onVehicleEdited(data);
    } catch (e) {
      await Navigator.of(context).maybePop();
      showErrorSnackbar(
          context: widget.context,
          errorMessage: 'Произошла ошибка при изменении транспорта',
          exception: e);
    }
  }

  @override
  void initState() {
    super.initState();
    now = DateTime.now().toUtc();
    now = now.subtract(
      Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
      ),
    );
    reset();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 3.0,
      ),
      child: GestureDetector(
        onTap: () {},
        child: ListView(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 36.0),
          physics: BouncingScrollPhysics(),
          children: [
            CardWidget(
              padding: const EdgeInsets.all(16.0),
              body: Text(
                'Изменить груз',
                style: ModernTextTheme.boldTitle,
              ),
            ),
            SizedBox(height: 16.0),
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
                    onSelected: (value) =>
                        setState(() => departureTime = value),
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
                    title: 'Макс. вес',
                    unit: 'кг.',
                    value: properties.weight,
                    onSelected: (value) =>
                        setState(() => properties.weight = value),
                  ),
                  NumberSelectWidget(
                    icon: FontAwesomeIcons.cube,
                    title: 'Макс. объём',
                    unit: 'см³',
                    value: properties.volume,
                    onSelected: (value) =>
                        setState(() => properties.volume = value),
                  ),
                  PriceSelectWidget(
                    price: properties.price,
                    onSelect: (value) =>
                        setState(() => properties.price = value),
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
                    onSelected: (value) =>
                        setState(() => dimensions.width = value),
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
                'Изображения',
                style: ModernTextTheme.title,
              ),
            ),
            SizedBox(height: 16.0),
            CardWidget(
              padding: const EdgeInsets.all(16.0),
              body: ImagesWidget(images: widget.data.images),
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
              onTap: (isValid()) ? () => editVehicle(context) : null,
              body: SingleLineInformationWidget(
                icon: Icons.check,
                label: 'Изменить груз',
                color: (isValid()) ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
