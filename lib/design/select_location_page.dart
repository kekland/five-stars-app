import 'package:five_stars/api/geocoding.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationPage extends StatefulWidget {
  final City selectedCity;
  final Function(City selected) onSelected;

  const SelectLocationPage({Key key, this.selectedCity, this.onSelected})
      : super(key: key);
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  String location = "Загрузка...";
  LatLng selectedPoint;

  @override
  void initState() {
    super.initState();
    if (widget.selectedCity != null) {
      this.selectedPoint =
          LatLng(widget.selectedCity.latitude, widget.selectedCity.longitude);
      this.location = widget.selectedCity.name;
    } else {
      this.selectedPoint = null;
      this.location = null;
    }
  }

  void onSelectLocation(BuildContext context, LatLng point) async {
    try {
      setState(() {
        location = "Загрузка...";
        selectedPoint = null;
      });
      final data = await GeocoderApi.getLocationName(point);
      setState(() {
        location = data;
        selectedPoint = point;
      });
    } catch (e) {
      location = null;
      selectedPoint = null;
      showErrorSnackbar(
          context: context,
          errorMessage: 'Произошла ошибка при выборе города.',
          exception: e);
    }
  }

  void onNext(BuildContext context) {
    widget.onSelected(
      City(
        latitude: selectedPoint.latitude,
        longitude: selectedPoint.longitude,
        name: location,
      ),
    );

    Navigator.of(context).pop();
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
              action: IconButton(
                icon: Icon(Icons.arrow_forward),
                color: Colors.pink,
                onPressed:
                    (this.selectedPoint != null) ? () => onNext(context) : null,
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(43.238949, 76.889709),
                      zoom: 10,
                    ),
                    onTap: (point) => onSelectLocation(context, point),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: {
                      if (selectedPoint != null)
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
                          value: location ?? "Не выбрано",
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
