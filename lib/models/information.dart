import 'package:five_stars/utils/vehicle_type.dart';

class VehicleInformation {
  String model;
  String description;
  VehicleType vehicleType;

  VehicleInformation({this.model, this.description, this.vehicleType});
  VehicleInformation.fromJson(Map json) {
    model = json['model'];
    description = json['description'];
    vehicleType = VehicleTypeUtils.fromJson(json['vehicleType']);
  }

  Map toJson() => {
    "model": model,
    "description": description,
    "vehicleType": VehicleTypeUtils.toJson(vehicleType),
  };

  bool isValid() {
    return model != null && description != null && vehicleType != null;
  }
}

class CargoInformation {
  bool dangerous;
  String description;
  VehicleType vehicleType;
  
  CargoInformation({this.dangerous, this.description, this.vehicleType});
  CargoInformation.fromJson(Map json) {
    dangerous = json['dangerous'] as bool;
    description = json['description'];
    vehicleType = VehicleTypeUtils.fromJson(json['vehicleType']);
  }

  Map toJson() => {
    "dangerous": dangerous,
    "description": description,
    "vehicleType": VehicleTypeUtils.toJson(vehicleType),
  };
  
  bool isValid() {
    return dangerous != null && description != null && vehicleType != null;
  }
}
