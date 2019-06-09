import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/vehicle_type.dart';

class CargoApi {
  static Future<List<Cargo>> getCargo() async {
    try {
      final response =
          await Dio().get('${baseUrl}/cargo', options: Api.options);
      List<Cargo> cargo = (response.data as List<dynamic>)
          .map((cargo) => Cargo.fromJson(cargo))
          .toList();
      return cargo;
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await getCargo();
      } else {
        rethrow;
      }
    }
  }
  
  static Future<List<Cargo>> getCargoBatched(List<String> identifiers) async {
    try {
      final response =
          await Dio().post('${baseUrl}/cargo/getBatched', data: {"values": identifiers}, options: Api.options);
      List<Cargo> cargo = (response.data as List<dynamic>)
          .map((cargo) => Cargo.fromJson(cargo))
          .toList();
      return cargo;
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await getCargoBatched(identifiers);
      } else {
        rethrow;
      }
    }
  }

  static Future<Cargo> addCargo({
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
      bool handled = await Api.handleError(e);
      if (handled) {
        return await addCargo(
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
      bool handled = await Api.handleError(e);
      if (handled) {
        return await editCargo(
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

  static Future<Cargo> deleteCargo({
    String id,
  }) async {
    try {
      final response =
          await Dio().delete('${baseUrl}/cargo/${id}', options: Api.options);
      return Cargo.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await deleteCargo(id: id);
      } else {
        rethrow;
      }
    }
  }
}
