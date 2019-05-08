import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';

class VehiclePageController extends Controller<VehiclePage> {
  VehiclePageController({Presenter<VehiclePage, VehiclePageController> presenter}) {
    this.presenter = presenter;
    data = null;
    load();
  }

  List<Vehicle> data;
  bool loading = false;
  String error;

  Future load() async {
    loading = true;
    error = "";
    Future.delayed(Duration(seconds: 2), () {
      data = [
        Vehicle(
          id: '1001',
          departureCity: City(name: 'Челябинск, Челябинская область'),
          arrivalCity: City(name: 'Костанай'),
          vehicleType: VehicleType.jumbo,
          volume: Volume(cubicMeter: 90),
          weight: Weight(ton: 20),
        ),
        Vehicle(
          id: '1002',
          departureCity: City(name: 'Усть-Каменогорск'),
          arrivalCity: City(name: 'Алматы'),
          vehicleType: VehicleType.dumpTruck,
          volume: Volume(cubicMeter: 20),
          weight: Weight(ton: 86),
        ),
        Vehicle(
          id: '1003',
          departureCity: City(name: 'Алматы'),
          arrivalCity: City(name: 'Астана'),
          vehicleType: VehicleType.allMetal,
          volume: Volume(cubicMeter: 86),
          weight: Weight(ton: 20),
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