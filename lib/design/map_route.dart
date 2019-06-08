import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/views/arrival_destination_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'card_widget.dart';

class MapRoutePage extends StatelessWidget {
  final City departure;
  final DateTime departureTime;
  final City arrival;
  final DateTime arrivalTime;

  const MapRoutePage(
      {Key key,
      this.departure,
      this.departureTime,
      this.arrival,
      this.arrivalTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    (departure.latitude + arrival.latitude) / 2.0,
                    (departure.longitude + arrival.longitude) / 2.0),
                zoom: 10,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              polylines: {
              },
              markers: {
                Marker(
                  markerId: MarkerId("departure-marker"),
                  position: LatLng(
                    departure.latitude,
                    departure.longitude,
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
                Marker(
                  markerId: MarkerId("arrival-marker"),
                  position: LatLng(
                    arrival.latitude,
                    arrival.longitude,
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                ),
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 24.0),
                child: CardWidget(
                  padding: const EdgeInsets.all(16.0),
                  body: DepartureArrivalWidget(
                    arrivalCity: arrival,
                    departureCity: departure,
                    arrivalDate: arrivalTime,
                    departureDate: departureTime,
                    arrivalColor: Colors.indigo.shade700,
                    departureColor: Colors.red.shade700,
                    isCargo: true,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AppBarWidget(
                title: Text('Путь'),
                includeBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
