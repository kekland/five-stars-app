import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/vehicle_type.dart';

class VehicleApi {
  static Future<List<Vehicle>> getVehicles() async {
    try {
      final response =
          await Dio().get('${baseUrl}/vehicle', options: Api.options);
      List<Vehicle> vehicle = (response.data as List<dynamic>)
          .map((item) => Vehicle.fromJson(item))
          .toList();
      return vehicle;
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await getVehicles();
      } else {
        rethrow;
      }
    }
  }
  
  static Future<List<Vehicle>> getVehicleBatched(List<String> identifiers) async {
    try {
      final response =
          await Dio().post('${baseUrl}/vehicle/getBatched', data: {"values": identifiers}, options: Api.options);
      List<Vehicle> vehicles = (response.data as List<dynamic>)
          .map((item) => Vehicle.fromJson(item))
          .toList();
      return vehicles;
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await getVehicleBatched(identifiers);
      } else {
        rethrow;
      }
    }
  }

  static Future<Vehicle> addVehicle({
    City arrival,
    City departure,
    double weight,
    double volume,
    VehicleType type,
    String description,
  }) async {
    try {
      final Map data = {
        "arrival": arrival.toJson(),
        "departure":  departure.toJson(),
        "weight": weight,
        "volume": volume,
        "vehicleType": VehicleTypeUtils.toJson(type),
        "description": description,
        "images": []
      };

      final response = await Dio()
          .post('${baseUrl}/vehicle', data: data, options: Api.options);
      return Vehicle.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await addVehicle(
          arrival: arrival,
          departure: departure,
          description: description,
          volume: volume,
          weight: weight,
          type: type,
        );
      } else {
        rethrow;
      }
    }
  }

  static Future<Vehicle> editVehicle({
    String id,
    City arrival,
    City departure,
    double weight,
    double volume,
    VehicleType type,
    String description,
  }) async {
    try {
      final Map data = {
        "arrival": arrival.toJson(),
        "departure": departure.toJson(),
        "weight": weight,
        "volume": volume,
        "vehicleType": VehicleTypeUtils.toJson(type),
        "description": description,
        "images": []
      };

      final response = await Dio()
          .put('${baseUrl}/vehicle/${id}', data: data, options: Api.options);
      return Vehicle.fromJson(response.data);
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await editVehicle(
          id: id,
          arrival: arrival,
          departure: departure,
          description: description,
          volume: volume,
          weight: weight,
          type: type,
        );
      } else {
        rethrow;
      }
    }
  }

  static Future<bool> deleteVehicle({
    String id,
  }) async {
    try {
      final response =
          await Dio().delete('${baseUrl}/vehicle/${id}', options: Api.options);
      return true;
    } catch (e) {
      bool handled = await Api.handleError(e);
      if (handled) {
        return await deleteVehicle(id: id);
      } else {
        rethrow;
      }
    }
  }
}