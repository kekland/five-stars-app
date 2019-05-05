import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';

class Vehicle {
  String id;
  
  City departureCity;
  City arrivalCity;

  Weight weight;
  Volume volume;

  VehicleType vehicleType;
}