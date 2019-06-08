import 'package:five_stars/api/api.dart';
import 'package:five_stars/controllers/registration_page_controller.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/cargo_page/cargo_alter_page.dart';
import 'package:flutter/material.dart';

class CargoAlterController extends Controller<CargoAlterPage> {
  CargoAlterController(
      {Presenter<CargoAlterPage, CargoAlterController> presenter}) {
    this.presenter = presenter;
    weight = ValidatedField(
      controller: this,
      textController: weightEditingController,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          double.tryParse(field) != null && double.tryParse(field) > 0,
    );
    volume = ValidatedField(
      controller: this,
      textController: volumeEditingController,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          double.tryParse(field) != null && double.tryParse(field) > 0,
    );
    price = ValidatedField(
      controller: this,
      textController: priceEditingController,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          double.tryParse(field) != null && double.tryParse(field) > 0,
    );
    info = ValidatedField(
      controller: this,
      textController: infoEditingController,
      errorMessage: 'Некорректные данные',
      validator: (field) => field.length > 0,
    );
  }

  String editingId;
  TextEditingController weightEditingController = TextEditingController();
  TextEditingController volumeEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController infoEditingController = TextEditingController();

  City selectedDepartureCity;
  City selectedArrivalCity;
  DateTime departureTime = DateTime.now();
  DateTime arrivalTime = DateTime.now().add(Duration(days: 1));
  VehicleType selectedVehicleType = VehicleType.closed;

  ValidatedField weight;
  ValidatedField volume;
  ValidatedField price;
  ValidatedField info;

  void setFields(Cargo cargo) {
    selectedDepartureCity = cargo?.departure;
    selectedArrivalCity = cargo?.arrival;
    departureTime = cargo?.departureTime ?? DateTime.now();
    arrivalTime = cargo?.arrivalTime ?? DateTime.now().add(Duration(days: 1));
    selectedVehicleType = cargo?.vehicleType ?? VehicleType.closed;

    weight.setValue(cargo?.weight?.kilogram?.toString(), true);
    volume.setValue(cargo?.volume?.cubicMeter?.toString(), true);
    price.setValue(cargo?.price?.toString(), true);
    info.setValue(cargo?.description, true);

    editingId = cargo.id;

    refresh();
  }

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
      showErrorSnackbar(
          context: context,
          errorMessage: "Произошла ошибка при добавлении груза",
          exception: e);
    }
  }

  void editCargo(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.pink);
      await CargoApi.editCargo(
        id: editingId,
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
      showInfoSnackbarMain(message: 'Груз изменен.');
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showErrorSnackbarMain(
          errorMessage: "Произошла ошибка при изменении груза", exception: e);
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
