import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cargo {
  String id;

  DateTime departureDate;
  City departureCity;

  DateTime arrivalDate;
  City arrivalCity;

  Weight weight;
  Volume volume;

  double shipmentCost;

  VehicleType vehicleType;
  String imageKeyword;

  bool get starred {
    if(SharedPreferencesManager.instance == null) {
      return false;
    }
    return SharedPreferencesManager.instance.getBool("cargo_${id}_star") ?? false;
  }

  void toggleStarred() {
    if(SharedPreferencesManager.instance == null) {
      return;
    }
    SharedPreferencesManager.instance.setBool("cargo_${id}_star", !starred);
  }

  Cargo({
    this.id,
    this.departureDate,
    this.departureCity,
    this.arrivalCity,
    this.arrivalDate,
    this.volume,
    this.weight,
    this.vehicleType,
    this.shipmentCost,
    this.imageKeyword,
  });
}
