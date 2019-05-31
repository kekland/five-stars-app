class City {
  String name;
  double latitude;
  double longitude;

  City({this.name, this.latitude, this.longitude});
  City.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    latitude = (json['latitude'] as num).toDouble();
    longitude = (json['longitude'] as num).toDouble();
  }

  Map toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
  };
}