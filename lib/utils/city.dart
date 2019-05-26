class City {
  String name;
  double latitude;
  double longitude;

  City({this.name, this.latitude, this.longitude});
  City.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    latitude = json['latitude'] as double;
    longitude = json['longitude'] as double;
  }
}