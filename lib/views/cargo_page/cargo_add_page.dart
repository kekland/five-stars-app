import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:five_stars/api/cargo.dart';
import 'package:five_stars/design/boolean_select_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/dimensions_widget.dart';
import 'package:five_stars/design/image_adder.dart';
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
import 'package:five_stars/views/arrival_destination_widget.dart';
import 'package:five_stars/views/cargo_page/cargo_expanded_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:better_uuid/uuid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<File> images;

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
    images = [];

    setState(() {});
  }

  void addCargo(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.red);
      var ref = FirebaseStorage.instance.ref().child('images');
      List imgs = [];
      for (final image in images) {
        final task = ref.child(Uuid.v4().toString()).putFile(image);
        final downloadUrl = await (await task.onComplete).ref.getDownloadURL();
        imgs.add(downloadUrl);
      }
      final data = await CargoApi.addCargo(
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
        images: imgs,
      );
      await Navigator.of(context).maybePop();

      await Navigator.of(context).push(
        TransparentRoute(
          builder: (context) {
            return CargoExpandedWidget(
              data: data,
              heroPrefix: '',
            );
          },
        ),
      );
    } catch (e) {
      await Navigator.of(context).maybePop();
      showErrorSnackbar(
          context: context,
          errorMessage: 'Произошла ошибка при добавлении груза.',
          exception: e);
    }
  }

  void loadSaved(BuildContext context) async {
    var configurations =
        SharedPreferencesManager.instance.getStringList('saved_cargo') ?? [];

    Map value = await showModernDialog(
      context: context,
      title: 'Выберите конфигурацию',
      actions: [
        FlatButton(
          child: Text('Отмена'),
          onPressed: () => Navigator.pop(context),
          textColor: Colors.purple,
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: configurations.map((name) {
            try {
              Map data = json.decode(SharedPreferencesManager.instance
                  .getString('saved_cargo_${name}'));

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.05), width: 2.0),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    borderRadius: BorderRadius.circular(12.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () => Navigator.of(context).pop(data),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            Text(name, style: ModernTextTheme.primaryAccented),
                      ),
                    ),
                  ),
                ),
              );
            } catch (e) {
              return SizedBox();
            }
          }).toList(),
        ),
      ),
    );

    if (value == null) return;
    setState(() {
      departure = City.fromJson(value['departure']);
      arrival = City.fromJson(value['arrival']);
      dimensions = Dimensions.fromJson(value['dimensions']);
      information = CargoInformation.fromJson(value['information']);
      properties = Properties.fromJson(value['properties']);
      images = value['images'].map((path) => File(path)).cast<File>().toList();
    });
  }

  void saveParams(BuildContext context) async {
    String name = null;
    bool value = await showModernDialog(
      context: context,
      title: 'Сохранить конфигурацию',
      body: StatefulBuilder(builder: (context, setState) {
        return Column(
          children: <Widget>[
            StringSelectWidget(
              icon: FontAwesomeIcons.save,
              title: 'Название конфигурации',
              onSelected: (value) => setState(() => name = value),
              value: name,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    child: Text('Отмена'),
                    onPressed: () => Navigator.pop(context, false),
                    textColor: Colors.black87),
                FlatButton(
                    child: Text('Сохранить'),
                    onPressed: (name != null && name.length > 0)
                        ? () => Navigator.pop(context, true)
                        : null,
                    textColor: Colors.purple),
              ],
            ),
          ],
        );
      }),
    );

    if (value != null && value) {
      try {
        var list =
            SharedPreferencesManager.instance.getStringList('saved_cargo') ??
                [];
        if (!list.contains(name)) {
          list.add(name);
        }

        Map value = {
          "departure": departure.toJson(),
          "arrival": arrival.toJson(),
          "dimensions": dimensions.toJson(),
          "information": information.toJson(),
          "properties": properties.toJson(),
          "images": images.map((image) => image.path).cast<String>().toList(),
        };

        SharedPreferencesManager.instance
            .setString('saved_cargo_${name}', json.encode(value));
        SharedPreferencesManager.instance.setStringList('saved_cargo', list);

        showInfoSnackbarMain(message: 'Конфигурация сохранена как "${name}"');
      } catch (e) {
        showErrorSnackbarMain(
            errorMessage: 'Произошла ошибка при сохранении конфигурации',
            exception: e);
      }
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
              BoolSelectWidget(
                title: 'Опасный груз',
                value: information.dangerous,
                onSelected: (value) =>
                    setState(() => information.dangerous = value),
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
          padding: EdgeInsets.zero,
          body: ImageSelector(
            onImageSelect: (v) => setState(() => images = v),
            images: images,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          onTap: () => loadSaved(context),
          body: SingleLineInformationWidget(
            icon: Icons.file_download,
            label: 'Загрузить из сохранённых',
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          onTap: (isValid()) ? () => saveParams(context) : null,
          body: SingleLineInformationWidget(
            icon: Icons.save,
            label: 'Сохранить параметры',
            color: (isValid()) ? Colors.purple : Colors.grey,
          ),
        ),
        SizedBox(height: 16.0),
        CardWidget(
          padding: const EdgeInsets.all(16.0),
          onTap: (isValid()) ? () => addCargo(context) : null,
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
