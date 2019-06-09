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