import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';

class Cargo {
  String id;

  DateTime departureDate;
  City departureCity;

  DateTime arrivalDate;
  City arrivalCity;

  Weight weight;
  Volume volume;

  double shipmentCost;

  VehicleType vehicleType;
  String imageKeyword;

  Cargo({
    this.id,
    this.departureDate,
    this.departureCity,
    this.arrivalCity,
    this.arrivalDate,
    this.volume,
    this.weight,
    this.vehicleType,
    this.shipmentCost,
    this.imageKeyword,
  });
}
