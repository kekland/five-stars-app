import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/views/vehicle_page/vehicle_widget.dart';
import 'package:flutter/material.dart';

class VehicleList extends StatefulWidget {
  final List<Vehicle> vehicle;
  final String vehicleHeroPrefix;

  static int vehicleListIndex = 0;

  const VehicleList({Key key, this.vehicle, this.vehicleHeroPrefix}) : super(key: key);

  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  List<Vehicle> vehicle;
  int vehicleListIndex;
  @override
  void initState() {
    vehicle = List.from(widget.vehicle);
    vehicle.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    vehicleListIndex = VehicleList.vehicleListIndex;
    VehicleList.vehicleListIndex++;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vehicle.length,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: VehicleWidget(
              data: vehicle[index],
              context: context,
              heroPrefix: '${widget.vehicleHeroPrefix}_$vehicleListIndex',
              onVehicleDeleted: () => setState(() => vehicle.removeAt(index)),
              onVehicleEdited: (data) => setState(() => vehicle[index] = data),
            ),
          ),
    );
  }
}
