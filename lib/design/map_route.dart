import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/route_model.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/arrival_destination_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'card_widget.dart';

class MapRoutePage extends StatefulWidget {
  final City departure;
  final DateTime departureTime;
  final City arrival;
  final DateTime arrivalTime;
  final DirectionRoute route;

  const MapRoutePage(
      {Key key,
      this.departure,
      this.departureTime,
      this.arrival,
      this.arrivalTime,
      this.route})
      : super(key: key);

  @override
  _MapRoutePageState createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  List<LatLng> points;
  @override
  void initState() {
    points =
        (widget.route != null) ? decodePolyline(widget.route.polyline) : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    (widget.departure.latitude + widget.arrival.latitude) / 2.0,
                    (widget.departure.longitude + widget.arrival.longitude) /
                        2.0),
                zoom: 10,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              polylines: (widget.route != null)
                  ? {
                      Polyline(
                        polylineId: PolylineId('polyline-route'),
                        points: points,
                        color: Colors.blue,
                        startCap: Cap.roundCap,
                        endCap: Cap.roundCap,
                        width: 10,
                      ),
                    }
                  : null,
              markers: {
                Marker(
                  markerId: MarkerId("departure-marker"),
                  position: LatLng(
                    widget.departure.latitude,
                    widget.departure.longitude,
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
                Marker(
                  markerId: MarkerId("arrival-marker"),
                  position: LatLng(
                    widget.arrival.latitude,
                    widget.arrival.longitude,
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
                  body: Column(
                    children: <Widget>[
                      DepartureArrivalWidget(
                        arrivalCity: widget.arrival,
                        departureCity: widget.departure,
                        arrivalDate: widget.arrivalTime,
                        departureDate: widget.departureTime,
                        arrivalColor: Colors.indigo.shade700,
                        departureColor: Colors.red.shade700,
                        isCargo: true,
                      ),
                      if (widget.route != null) ...[
                        DividerWidget(),
                        TwoLineInformationWidgetExpanded(
                          iconColor: ModernTextTheme.captionIconColor,
                          icon: FontAwesomeIcons.route,
                          title: 'Дистанция',
                          value: (widget.route.distance / 1000.0)
                              .toStringAsFixed(1)
                              .toString(),
                          unit: "км.",
                        ),
                      ],
                    ],
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
