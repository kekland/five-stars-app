class DirectionRoute {
  String polyline;
  double distance;

  DirectionRoute({this.polyline, this.distance});

  DirectionRoute.fromJson(Map json) {
    polyline = json['polyline'] as String;
    distance = (json['distance'] as num).toDouble();
  }
}