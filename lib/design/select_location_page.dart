import 'package:five_stars/api/geocoding.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  LatLng pendingPoint;

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
        pendingPoint = point;
      });
      final data = await GeoApi.getLocationName(point);
      setState(() {
        location = data;
        selectedPoint = point;
        pendingPoint = null;
      });
    } catch (e) {
      location = null;
      selectedPoint = null;
      showErrorSnackbarKeyed(
          key: scaffoldKey,
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

  void onCancel(BuildContext context) {
    widget.onSelected(null);

    Navigator.of(context).pop();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
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
                    position: selectedPoint,
                  ),
                if (pendingPoint != null)
                  Marker(
                    markerId: MarkerId("pending-point"),
                    position: pendingPoint,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure),
                  ),
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CardWidget(
                      padding: const EdgeInsets.all(16.0),
                      body: TwoLineInformationWidgetExpanded(
                        icon: Icons.pin_drop,
                        title: 'Выбранное место',
                        value: location ?? "Не выбрано",
                        unit: '',
                        iconColor: Colors.pink,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CardWidget(
                      padding: const EdgeInsets.all(16.0),
                      onTap: () => onCancel(context),
                      body: SingleLineInformationWidget(
                        icon: FontAwesomeIcons.times,
                        label: 'Отмена выбора',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AppBarWidget(
                title: Text('Выберите место'),
                action: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  color: Colors.pink,
                  onPressed: (this.selectedPoint != null)
                      ? () => onNext(context)
                      : null,
                ),
                includeBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
