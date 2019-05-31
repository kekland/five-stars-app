import 'package:five_stars/api/api.dart';
import 'package:five_stars/controllers/registration_page_controller.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/cargo_page/cargo_add_sheet.dart';
import 'package:flutter/material.dart';

class CargoAddController extends Controller<CargoAddPage> {
  CargoAddController({Presenter<CargoAddPage, CargoAddController> presenter}) {
    this.presenter = presenter;
    weight = ValidatedField(
      controller: this,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          double.tryParse(field) != null && double.tryParse(field) > 0,
    );
    volume = ValidatedField(
      controller: this,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          double.tryParse(field) != null && double.tryParse(field) > 0,
    );
    price = ValidatedField(
      controller: this,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          double.tryParse(field) != null && double.tryParse(field) > 0,
    );
    info = ValidatedField(
      controller: this,
      errorMessage: 'Некорректные данные',
      validator: (field) => field.length > 0,
    );
  }

  City selectedDepartureCity;
  City selectedArrivalCity;
  DateTime departureTime = DateTime.now();
  DateTime arrivalTime = DateTime.now();
  VehicleType selectedVehicleType = VehicleType.closed;

  ValidatedField weight;
  ValidatedField volume;
  ValidatedField price;
  ValidatedField info;

  void addCargo(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.pink);
      await CargoApi.addCargo(
        arrival: selectedArrivalCity,
        departure: selectedDepartureCity,
        arrivalTime: arrivalTime,
        departureTime: departureTime,
        description: info.value,
        price: double.parse(price.value),
        volume: double.parse(volume.value),
        weight: double.parse(weight.value),
        type: selectedVehicleType,
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showInfoSnackbar(context: context, message: 'Груз добавлен.');
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showErrorSnackbar(context: context, errorMessage: "Произошла ошибка при добавлении груза", exception: e);
    }
  }

  bool isValid() {
    return selectedDepartureCity != null &&
        selectedArrivalCity != null &&
        departureTime.isBefore(arrivalTime) &&
        selectedVehicleType != null &&
        weight.isValid() &&
        volume.isValid() &&
        price.isValid() &&
        info.isValid();
  }
}
