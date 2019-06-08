import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cargo {
  String id;

  DateTime departureTime;
  City departure;

  DateTime arrivalTime;
  City arrival;

  Weight weight;
  Volume volume;
  double price;
  
  String description;

  VehicleType vehicleType;

  String ownerId;

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
    this.ownerId,
    this.description,
    this.updatedAt,
    this.createdAt,
  });

  Cargo.fromJson(Map<String, dynamic> json) {
    id = json['meta']['id'] as String;

    departureTime = DateTime.parse(json['departure']['time']);
    departure = City.fromJson(json['departure']['position']);

    arrivalTime = DateTime.parse(json['arrival']['time']);
    arrival = City.fromJson(json['arrival']['position']);

    weight = Weight(kilogram: (json['weight'] as num).toDouble());
    volume = Volume(cubicMeter: (json['volume'] as num).toDouble());
    price = (json['price'] as num).toDouble();

    vehicleType = VehicleTypeUtils.fromJson(json['vehicleType'] as String);

    ownerId = json['ownerId'] as String;
    description = json['description'] as String;

    createdAt = DateTime.fromMillisecondsSinceEpoch(json['meta']['created']);
    updatedAt = DateTime.fromMillisecondsSinceEpoch(json['meta']['updated']);

    departureTime = departureTime.toLocal();
    arrivalTime = arrivalTime.toLocal();
  }
}
