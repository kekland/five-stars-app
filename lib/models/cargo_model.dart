import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/models/properties.dart';
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

  City departure;
  DateTime departureTime;

  City arrival;
  DirectionRoute route;

  Properties properties;
  Dimensions dimensions;
  CargoInformation information;

  List<dynamic> images;
  
  String owner;
  DateTime createdAt;

  bool archived;
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
    this.archived,
    this.createdAt,
    this.owner,
    this.dimensions,
    this.images,
    this.route,
    this.verified,
    this.information,
    this.properties,
  });

  Cargo.fromJson(Map json) {
    id = json['meta']['id'];

    departure = City.fromJson(json['departure']);
    departureTime = DateTime.parse(json['departureTime']);

    arrival = City.fromJson(json['arrival']);
    route = json['route'] != null? DirectionRoute.fromJson(json['route']) : null;

    properties = Properties.fromJson(json['properties']);
    dimensions = Dimensions.fromJson(json['dimensions']);
    information = CargoInformation.fromJson(json['information']);

    images = json['images'];

    archived = json['archived'] as bool;
    verified = json['verified'] as bool;

    createdAt = DateTime.fromMillisecondsSinceEpoch(json['meta']['created']);
    owner = json['owner'];
  }
}
