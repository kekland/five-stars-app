import 'package:dio/dio.dart';
import 'package:five_stars/api/api.dart';
import 'package:five_stars/models/cargo_model.dart';

class CargoApi {
  static Future<List<Cargo>> getCargo() async {
    try {
      final response = await Dio().get('${baseUrl}/cargo', options: Api.options);

      List<Cargo> cargo = (response.data as List<Map<String, dynamic>>).map((cargo) => Cargo.fromJson(cargo)).toList();
      return cargo;
    } catch (e) {
      rethrow;
    }
  }
}
