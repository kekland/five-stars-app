import 'package:five_stars/design/shadows/shadows.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/views/cargo_page/cargo_list.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:five_stars/views/vehicle_page/vehicle_list.dart';
import 'package:flutter/material.dart';

class VehiclePage extends StatelessWidget {
  final List<Vehicle> vehicle;

  const VehiclePage({Key key, this.vehicle}) : super(key: key);
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Найденный груз', style: TextStyle(color: Colors.black)),
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: VehicleList(vehicle: vehicle, vehicleHeroPrefix: 'vehicle_page'),
    );
  }
}
