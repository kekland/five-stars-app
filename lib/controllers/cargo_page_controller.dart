import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';
import 'package:five_stars/views/cargo/cargo_page.dart';

class CargoPageController extends Controller<CargoPage> {
  CargoPageController({Presenter<CargoPage, CargoPageController> presenter}) {
    this.presenter = presenter;
    data = null;
    load();
  }

  List<Cargo> data;
  bool loading = false;
  String error;

  Future load() async {
    loading = true;
    error = "";
    Future.delayed(Duration(seconds: 2), () {
      data = [
        Cargo(
          id: '1001',
          departureCity: City(name: 'Челябинск, Челябинская область'),
          departureDate: DateTime.utc(2019, 4, 9),
          arrivalCity: City(name: 'Костанай'),
          arrivalDate: DateTime.utc(2019, 4, 10),
          imageKeyword: 'Шины',
          vehicleType: VehicleType.option1,
          volume: Volume(cubicMeter: 90),
          weight: Weight(ton: 20),
          shipmentCost: 130000.0,
        ),
        Cargo(
          id: '1002',
          departureCity: City(name: 'Усть-Каменогорск'),
          departureDate: DateTime.utc(2019, 9, 26),
          arrivalCity: City(name: 'Алматы'),
          arrivalDate: DateTime.utc(2019, 9, 28),
          imageKeyword: 'Мука',
          vehicleType: VehicleType.option1,
          volume: Volume(cubicMeter: 20),
          weight: Weight(ton: 86),
          shipmentCost: 190000.0,
        ),
        Cargo(
          id: '1003',
          departureCity: City(name: 'Алматы'),
          departureDate: DateTime.utc(2019, 7, 31),
          arrivalCity: City(name: 'Астана'),
          arrivalDate: DateTime.utc(2019, 8, 2),
          imageKeyword: 'Стройматериалы',
          vehicleType: VehicleType.option1,
          volume: Volume(cubicMeter: 86),
          weight: Weight(ton: 20),
          shipmentCost: 820000.0,
        ),
      ];
      loading = false;
      presenter.refresh();
    });
  }

  FutureState getFutureState() {
    if(loading) {
      return FutureState.Loading;
    }
    else {
      if(error != "") {
        return FutureState.Error;
      }
      else {
        return FutureState.Success;
      }
    }
  }
}