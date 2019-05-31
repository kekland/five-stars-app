import 'package:five_stars/api/geocoding.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  String location = "Загрузка...";
  LatLng selectedPoint;

  void onSelectLocation(LatLng point) async {
    setState(() => location = "Загрузка...");
    selectedPoint = point;
    final data = await GeocoderApi.getLocationName(point);
    setState(() => location = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AppBarWidget(
              title: Text('Выберите место'),
              includeBackButton: true,
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(43.238949, 76.889709),
                      zoom: 10,
                    ),
                    onTap: onSelectLocation,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: {
                      Marker(
                        markerId: MarkerId("selected-point"),
                        infoWindow: InfoWindow(
                          title: 'Выбранное место',
                        ),
                        position: selectedPoint,
                      )
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 24.0),
                      child: CardWidget(
                        padding: const EdgeInsets.all(16.0),
                        body: TwoLineInformationWidget(
                          icon: Icons.pin_drop,
                          title: 'Выбранное место',
                          value: location,
                          unit: '',
                          iconColor: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
