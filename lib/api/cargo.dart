import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/dimensions.dart';
import 'package:five_stars/models/information.dart';
import 'package:five_stars/models/properties.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:flutter/material.dart';

class CargoApi {
  static Future<List<Cargo>> getCargo({
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
    bool verified,
    VehicleType vehicleType,
  }) async {
    try {
      final response = await Api.client.post('$baseUrl/cargo/get', data: {
        "departure": departure?.name,
        "arrival": arrival?.name,
        "departureTime": (departureTimes != null)? {
          "lower": departureTimes.lower.toIso8601String(),
          "upper": departureTimes.upper.toIso8601String(),
        } : null,
        "weight": weight != null ? weight.toJson() : null,
        "volume": volume != null ? volume.toJson() : null,
        "distance": distance != null ? distance.toJson() : null,
        "width": width != null ? width.toJson() : null,
        "height": height != null ? height.toJson() : null,
        "length": length != null ? length.toJson() : null,
        "archived": showArchived,
        "removeOld": removeOld,
        "verified": verified,
        "oldThreshold": 7 * 24 * 60 * 60 * 1000,
        "vehicleType":
            vehicleType != null ? VehicleTypeUtils.toJson(vehicleType) : null,
      });

      List<Cargo> cargo = (response.data as List<dynamic>)
          .map((data) => Cargo.fromJson(data))
          .cast<Cargo>()
          .toList();
      return cargo;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<Cargo>> getCargoBatched(
      BuildContext context, List<String> identifiers) async {
    try {
      final response = await Api.client.post('${baseUrl}/cargo/getBatched',
          data: {"values": identifiers}, options: Api.options);
      List<Cargo> cargo = (response.data as List<dynamic>)
          .map((cargo) => Cargo.fromJson(cargo))
          .toList();
      return cargo;
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await getCargoBatched(context, identifiers);
      } else {
        rethrow;
      }
    }
  }

  static Future<Cargo> addCargo({
    @required BuildContext context,
    City departure,
    City arrival,
    DateTime departureTime,
    Properties properties,
    Dimensions dimensions,
    CargoInformation information,
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
          .post('${baseUrl}/cargo', data: data, options: Api.options);
      return Cargo.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await addCargo(
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

  static Future<Cargo> editCargo({
    @required BuildContext context,
    String id,
    City departure,
    City arrival,
    DateTime departureTime,
    Properties properties,
    Dimensions dimensions,
    CargoInformation information,
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
          .put('${baseUrl}/cargo/${id}', data: data, options: Api.options);
      return Cargo.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await editCargo(
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

  static Future<bool> deleteCargo({
    @required BuildContext context,
    String id,
  }) async {
    try {
      final response =
          await Api.client.delete('${baseUrl}/cargo/${id}', options: Api.options);
      return true;
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await deleteCargo(context: context, id: id);
      } else {
        rethrow;
      }
    }
  }

  static Future<bool> setCargoFavoriteStatus({
    @required BuildContext context,
    @required String cargoId,
    @required bool favorite,
  }) async {
    try {
      final response =
          await Api.client.post('$baseUrl/cargo/$cargoId/${(favorite)? 'favorite' : 'unfavorite'}', options: Api.options);
      return true;
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await setCargoFavoriteStatus(context: context, cargoId: cargoId, favorite: favorite);
      } else {
        rethrow;
      }
    }
  }
}
