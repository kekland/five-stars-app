import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cargo {
  int id;

  DateTime departureTime;
  City departure;

  DateTime arrivalTime;
  City arrival;

  Weight weight;
  Volume volume;
  double price;

  VehicleType vehicleType;

  User owner;

  DateTime createdAt;
  DateTime updatedAt;

  bool get starred {
    if (SharedPreferencesManager.instance == null) {
      return false;
    }
    return SharedPreferencesManager.instance.getBool("cargo_${id}_star") ?? false;
  }

  void toggleStarred() {
    if (SharedPreferencesManager.instance == null) {
      return;
    }
    SharedPreferencesManager.instance.setBool("cargo_${id}_star", !starred);
  }

  Cargo({
    this.id,
    this.departureTime,
    this.departure,
    this.arrivalTime,
    this.arrival,
    this.weight,
    this.volume,
    this.price,
    this.vehicleType,
    this.owner,
    this.updatedAt,
    this.createdAt,
  });

  Cargo.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;

    departureTime = DateTime.parse(json['departureTime']);
    departure = City.fromJson(json['departure']);

    arrivalTime = DateTime.parse(json['arrivalTime']);
    arrival = City.fromJson(json['arrival']);

    weight = Weight(kilogram: json['weight'] as double);
    volume = Volume(cubicMeter: json['volume'] as double);
    price = json['price'] as double;
    vehicleType = VehicleTypeUtils.fromJson(json['vehicleType'] as String);

    owner = User.fromJson(json['owner']);

    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
  }
}
