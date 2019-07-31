import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/models/properties.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:flutter/material.dart';

class VehicleApi {
  static Future<List<Vehicle>> getVehicles({
    @required BuildContext context,
    City departure,
    City arrival,
    Bounded<DateTime> departureTimes,
    Bounded<double> weight,
    Bounded<double> volume,
    Bounded<double> distance,
    Bounded<double> width,
    Bounded<double> height,
    Bounded<double> length,
    bool showArchived,
    bool removeOld,
    VehicleType vehicleType,
  }) async {
    try {
      final response = await Api.client.post('$baseUrl/vehicle/get', data: {
        "departure": departure != null ? departure.toJson() : null,
        "arrival": arrival != null ? arrival.toJson() : null,
        "departureTime": (departureTimes != null)
            ? {
                "lower": departureTimes.lower.toIso8601String(),
                "upper": departureTimes.upper.toIso8601String(),
              }
            : null,
        "weight": weight != null ? weight.toJson() : null,
        "volume": volume != null ? volume.toJson() : null,
        "distance": distance != null ? distance.toJson() : null,
        "width": width != null ? width.toJson() : null,
        "height": height != null ? height.toJson() : null,
        "length": length != null ? length.toJson() : null,
        "archived": showArchived,
        "removeOld": removeOld,
        "oldThreshold": 7 * 24 * 60 * 60 * 1000,
        "verified": true,
        "vehicleType":
            vehicleType != null ? VehicleTypeUtils.toJson(vehicleType) : null,
      });

      List<Vehicle> vehicles = (response.data as List<dynamic>)
          .map((data) => Vehicle.fromJson(data))
          .cast<Vehicle>()
          .toList();
      return vehicles;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<Vehicle> addVehicle({
    @required BuildContext context,
    City departure,
    City arrival,
    DateTime departureTime,
    Properties properties,
    Dimensions dimensions,
    VehicleInformation information,
    List images,
  }) async {
    try {
      final Map data = {
        "arrival": arrival.toJson(),
        "departure": departure.toJson(),
        "departureTime": departureTime.toIso8601String(),
        "properties": properties.toJson(),
        "dimensions": dimensions.toJson(),
        "information": information.toJson(),
        "images": images,
      };

      final response = await Api.client
          .post('${baseUrl}/vehicle', data: data, options: Api.options);
      return Vehicle.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await addVehicle(
          context: context,
          departure: departure,
          arrival: arrival,
          departureTime: departureTime,
          properties: properties,
          dimensions: dimensions,
          information: information,
        );
      } else {
        rethrow;
      }
    }
  }

  static Future<Vehicle> editVehicle({
    @required BuildContext context,
    String id,
    City departure,
    City arrival,
    DateTime departureTime,
    Properties properties,
    Dimensions dimensions,
    VehicleInformation information,
  }) async {
    try {
      final Map data = {
        "arrival": arrival.toJson(),
        "departure": departure.toJson(),
        "departureTime": departureTime.toIso8601String(),
        "properties": properties.toJson(),
        "dimensions": dimensions.toJson(),
        "information": information.toJson(),
        "images": [],
      };

      final response = await Api.client
          .put('${baseUrl}/vehicle/${id}', data: data, options: Api.options);
      return Vehicle.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await editVehicle(
          context: context,
          id: id,
          arrival: arrival,
          departure: departure,
          departureTime: departureTime,
          dimensions: dimensions,
          information: information,
          properties: properties,
        );
      } else {
        rethrow;
      }
    }
  }

  static Future<bool> deleteVehicle({
    @required BuildContext context,
    String id,
  }) async {
    try {
      final response = await Api.client
          .delete('${baseUrl}/vehicle/${id}', options: Api.options);
      return true;
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await deleteVehicle(context: context, id: id);
      } else {
        rethrow;
      }
    }
  }

  static Future<bool> setVehicleFavoriteStatus({
    @required BuildContext context,
    @required String vehicleId,
    @required bool favorite,
  }) async {
    try {
      final response = await Api.client.post(
          '$baseUrl/vehicle/$vehicleId/${(favorite) ? 'favorite' : 'unfavorite'}',
          options: Api.options);
      return true;
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await setVehicleFavoriteStatus(
            context: context, vehicleId: vehicleId, favorite: favorite);
      } else {
        rethrow;
      }
    }
  }
}
