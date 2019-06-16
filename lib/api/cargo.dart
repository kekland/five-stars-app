import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:flutter/material.dart';

class CargoApi {
  static Future<List<Cargo>> getCargo({
    @required BuildContext context,
    City departure,
    City arrival,
    DateTime departureTime,
    Bounded weight,
    Bounded volume,
    Bounded distance,
    Bounded width,
    Bounded height,
    Bounded length,
    bool showArchived,
    bool removeOld,
    VehicleType vehicleType,
  }) async {
    try {
      final response = await Dio().post('$baseUrl/cargo/get', data: {
        "departure": departure?.name,
        "arrival": arrival?.name,
        "departureTime":
            departureTime != null ? departureTime.toIso8601String() : null,
        "weight": weight != null ? weight.toJson() : null,
        "volume": volume != null ? volume.toJson() : null,
        "distance": distance != null ? distance.toJson() : null,
        "width": width != null ? width.toJson() : null,
        "height": height != null ? height.toJson() : null,
        "length": length != null ? length.toJson() : null,
        "archived": showArchived,
        "removeOld": removeOld,
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
      final response = await Dio().post('${baseUrl}/cargo/getBatched',
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
    City arrival,
    City departure,
    DateTime arrivalTime,
    DateTime departureTime,
    double price,
    double weight,
    double volume,
    VehicleType type,
    String description,
  }) async {
    try {
      final Map data = {
        "arrival": {
          "position": arrival.toJson(),
          "time": arrivalTime.toIso8601String()
        },
        "departure": {
          "position": departure.toJson(),
          "time": departureTime.toIso8601String()
        },
        "price": price,
        "weight": weight,
        "volume": volume,
        "vehicleType": VehicleTypeUtils.toJson(type),
        "description": description,
        "images": []
      };

      final response = await Dio()
          .post('${baseUrl}/cargo', data: data, options: Api.options);
      return Cargo.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(context: context, exception: e);
      if (handled) {
        return await addCargo(
          context: context,
          arrival: arrival,
          departure: departure,
          arrivalTime: arrivalTime,
          departureTime: departureTime,
          description: description,
          price: price,
          volume: volume,
          weight: weight,
          type: type,
        );
      } else {
        rethrow;
      }
    }
  }

  static Future<Cargo> editCargo({
    @required BuildContext context,
    String id,
    City arrival,
    City departure,
    DateTime arrivalTime,
    DateTime departureTime,
    double price,
    double weight,
    double volume,
    VehicleType type,
    String description,
  }) async {
    try {
      final Map data = {
        "arrival": {
          "position": arrival.toJson(),
          "time": arrivalTime.toIso8601String()
        },
        "departure": {
          "position": departure.toJson(),
          "time": departureTime.toIso8601String()
        },
        "price": price,
        "weight": weight,
        "volume": volume,
        "vehicleType": VehicleTypeUtils.toJson(type),
        "description": description,
        "images": []
      };

      final response = await Dio()
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
          arrivalTime: arrivalTime,
          departureTime: departureTime,
          description: description,
          price: price,
          volume: volume,
          weight: weight,
          type: type,
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
          await Dio().delete('${baseUrl}/cargo/${id}', options: Api.options);
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
}
