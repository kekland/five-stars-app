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
      rethrow;
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
        "vehicleType": VehicleTypeUtils.vehicleTypeNames[type],
        "description": description,
        "images": []
      };

      final response = await Dio().post('${baseUrl}/cargo', options: Api.options);
      return Cargo.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
