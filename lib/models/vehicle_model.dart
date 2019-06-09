import 'package:five_stars/models/route_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';

class Vehicle {
  String id;
  
  City departure;
  City arrival;
  DirectionRoute route;

  Weight weight;
  Volume volume;
  String description;

  VehicleType vehicleType;

  DateTime createdAt;
  DateTime updatedAt;

  String ownerId;
  
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
    this.departure,
    this.arrival,
    this.volume,
    this.weight,
    this.description,
    this.ownerId,
    this.route,
    this.vehicleType,
  });

  Vehicle.fromJson(Map json) {
    id = json['meta']['id'] as String;

    departure = City.fromJson(json['departure']['position']);
    arrival = City.fromJson(json['arrival']['position']);

    weight = Weight(kilogram: (json['weight'] as num).toDouble());
    volume = Volume(cubicMeter: (json['volume'] as num).toDouble());
    vehicleType = VehicleTypeUtils.fromJson(json['vehicleType'] as String);

    ownerId = json['ownerId'] as String;
    description = json['description'] as String;

    createdAt = DateTime.fromMillisecondsSinceEpoch(json['meta']['created']);
    updatedAt = DateTime.fromMillisecondsSinceEpoch(json['meta']['updated']);

    route = json['route'] != null? DirectionRoute.fromJson(json['route']) : null;
  }
}