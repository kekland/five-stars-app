import 'package:five_stars/controllers/registration_page_controller.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/cargo_page/cargo_add_sheet.dart';

class CargoAddController extends Controller<CargoAddPage> {
  CargoAddController({Presenter<CargoAddPage, CargoAddController> presenter}) {
    this.presenter = presenter;
    weight = ValidatedField(
      controller: this,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          int.tryParse(field) != null && int.tryParse(field) > 0,
    );
    volume = ValidatedField(
      controller: this,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          int.tryParse(field) != null && int.tryParse(field) > 0,
    );
    price = ValidatedField(
      controller: this,
      errorMessage: 'Некорректные данные',
      validator: (field) =>
          int.tryParse(field) != null && int.tryParse(field) > 0,
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
