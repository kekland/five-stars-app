import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/route_model.dart';
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
  City arrival;
  DirectionRoute route;

  double weight;
  double volume;
  double price;
  Dimensions dimensions;

  List<dynamic> images;
  
  bool dangerous;
  String description;
  VehicleType vehicleType;

  DocumentReference owner;
  DateTime createdAt;

  bool verified;


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
    this.arrival,
    this.weight,
    this.volume,
    this.price,
    this.vehicleType,
    this.owner,
    this.description,
    this.dangerous,
    this.dimensions,
    this.images,
    this.route,
    this.verified,
    this.createdAt,
  });

  Cargo.fromJson(String id, Map json) {
    id = id;
    arrival = City.fromJson(json['arrival']);
    createdAt = (json['createdAt'] as Timestamp).toDate();

    departure = City.fromJson(json['departure']);

    departureTime = (json['departure']['date'] as Timestamp).toDate();
    departureTime = departureTime.toLocal();

    dimensions = Dimensions.fromJson(json['dimensions']);
    
    images = json['images'];

    description = json['information']['description'] as String;
    dangerous = json['information']['dangerous'] as bool;
    vehicleType = VehicleTypeUtils.fromJson(json['information']['vehicleType'] as String);

    owner = json['owner'];

    weight = (json['weight'] as num).toDouble();
    volume = (json['volume'] as num).toDouble();
    price = (json['price'] as num).toDouble();
    route = json['route'] != null? DirectionRoute.fromJson(json['route']) : null;

    verified = json['verified'] as bool;
  }
}
