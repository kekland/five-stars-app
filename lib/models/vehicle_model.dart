import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';

class Vehicle {
  String id;
  
  City departureCity;
  City arrivalCity;

  Weight weight;
  Volume volume;

  VehicleType vehicleType;
  
  bool get starred {
    if(SharedPreferencesManager.instance == null) {
      return false;
    }
    return SharedPreferencesManager.instance.getBool("vehicle_${id}_star") ?? false;
  }

  void toggleStarred() {
    if(SharedPreferencesManager.instance == null) {
      return;
    }
    SharedPreferencesManager.instance.setBool("vehicle_${id}_star", !starred);
  }
  
  Vehicle({
    this.id,
    this.departureCity,
    this.arrivalCity,
    this.volume,
    this.weight,
    this.vehicleType,
  });
}