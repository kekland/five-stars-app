import 'package:five_stars/api/api.dart';
import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/controllers/registration_page_controller.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/vehicle_page/vehicle_alter_page.dart';
import 'package:flutter/material.dart';

class VehicleAlterController extends Controller<VehicleAlterPage> {
  VehicleAlterController(
      {Presenter<VehicleAlterPage, VehicleAlterController> presenter}) {
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
  TextEditingController infoEditingController = TextEditingController();

  City selectedDepartureCity;
  City selectedArrivalCity;
  VehicleType selectedVehicleType = VehicleType.closed;

  ValidatedField weight;
  ValidatedField volume;
  ValidatedField info;

  void setFields(Vehicle vehicle) {
    selectedDepartureCity = vehicle?.departure;
    selectedArrivalCity = vehicle?.arrival;
    selectedVehicleType = vehicle?.vehicleType ?? VehicleType.closed;

    weight.setValue(vehicle?.weight?.kilogram?.toString(), true);
    volume.setValue(vehicle?.volume?.cubicMeter?.toString(), true);
    info.setValue(vehicle?.description, true);

    editingId = vehicle.id;

    refresh();
  }

  void addVehicle(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.pink);
      await VehicleApi.addVehicle(
        arrival: selectedArrivalCity,
        departure: selectedDepartureCity,
        description: info.value,
        volume: double.parse(volume.value),
        weight: double.parse(weight.value),
        type: selectedVehicleType,
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showInfoSnackbar(context: context, message: 'Транспорт добавлен.');
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showErrorSnackbar(
          context: context,
          errorMessage: "Произошла ошибка при добавлении транспорта",
          exception: e);
    }
  }

  void editVehicle(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.pink);
      await VehicleApi.editVehicle(
        id: editingId,
        arrival: selectedArrivalCity,
        departure: selectedDepartureCity,
        description: info.value,
        volume: double.parse(volume.value),
        weight: double.parse(weight.value),
        type: selectedVehicleType,
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showInfoSnackbarMain(message: 'Транспорт изменен.');
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showErrorSnackbarMain(
          errorMessage: "Произошла ошибка при изменении транспорта", exception: e);
    }
  }

  bool isValid() {
    return selectedDepartureCity != null &&
        selectedArrivalCity != null &&
        selectedVehicleType != null &&
        weight.isValid() &&
        volume.isValid() &&
        info.isValid();
  }
}
