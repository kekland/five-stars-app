import 'dart:convert';

import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/models/properties.dart';
import 'package:five_stars/models/route_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:flutter/material.dart';

class Vehicle {
  String id;

  City departure;
  DateTime departureTime;

  City arrival;
  DirectionRoute route;

  Properties properties;
  Dimensions dimensions;
  VehicleInformation information;

  List<dynamic> images;

  String owner;
  DateTime createdAt;

  bool archived;
  bool verified;

  bool get starred {
    if (SharedPreferencesManager.instance == null) {
      return false;
    }
    return SharedPreferencesManager.instance.getBool("favorite_vehicle_$id") ??
        false;
  }

  void toggleStarred(BuildContext context) {
    if (SharedPreferencesManager.instance == null) {
      return;
    }
    try {
      List<dynamic> data = json.decode(
          SharedPreferencesManager.instance.getString('favorite_vehicle') ??
              '[]');
      if (data.contains(id)) {
        data.remove(id);
        SharedPreferencesManager.instance.setBool('favorite_vehicle_$id', false);
        VehicleApi.setVehicleFavoriteStatus(
            context: context, vehicleId: id, favorite: false);
      } else {
        data.add(id);
        SharedPreferencesManager.instance.setBool('favorite_vehicle_$id', true);
        VehicleApi.setVehicleFavoriteStatus(
            context: context, vehicleId: id, favorite: true);
      }
      SharedPreferencesManager.instance
          .setString("favorite_vehicle", json.encode(data));
    } catch (e) {
      showErrorSnackbar(
          context: context,
          errorMessage: 'Произошла ошибка при изменении статуса груза',
          exception: e);
    }
  }

  Vehicle({
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

  Vehicle.fromJson(Map json) {
    id = json['meta']['id'];

    departure = City.fromJson(json['departure']);
    departureTime = DateTime.parse(json['departureTime']);

    arrival = City.fromJson(json['arrival']);
    route =
        json['route'] != null ? DirectionRoute.fromJson(json['route']) : null;

    properties = Properties.fromJson(json['properties']);
    dimensions = Dimensions.fromJson(json['dimensions']);
    information = VehicleInformation.fromJson(json['information']);

    images = json['images'];

    archived = json['archived'] as bool;
    verified = json['verified'] as bool;

    createdAt = DateTime.fromMillisecondsSinceEpoch(json['meta']['created']);
    owner = json['owner'];
  }
}
