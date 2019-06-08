import 'package:dio/dio.dart';
import 'package:five_stars/api/secret.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoApi {
  static Future<List<LatLng>> getDirections(LatLng departure, LatLng arrival) {
    try {

    }
    catch(e) {
      rethrow;
    }
  }
  static Future<String> getLocationName(LatLng point) async {
    try {
      final response = await Dio()
          .get("https://geocode-maps.yandex.ru/1.x/", queryParameters: {
        "apikey": YANDEX_API_KEY,
        "format": "json",
        "geocode": "${point.longitude},${point.latitude}",
      });
      List<dynamic> features = response.data['response']['GeoObjectCollection']['featureMember'];
      List<dynamic> components = features.first['GeoObject']['metaDataProperty']['GeocoderMetaData']['Address']['Components'];
      
      String country = components[0]['name'];
      String city = null;
      components.forEach((component) {
        if(component['kind'] == 'locality') {
          city = component['name'];
        }
        else if(component['kind'] == 'province') {
          city = component['name'];
        }
      });
      print(components);

      return "$city, $country";
    } catch (err) {
      rethrow;
    }
  }
}
