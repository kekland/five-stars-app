class Properties {
  double weight;
  double volume;

  Properties({this.weight, this.volume});
  Properties.fromJson(Map json) {
    this.weight = (json['weight'] as num).toDouble();
    this.volume = (json['volume'] as num).toDouble();
  }

  Map toJson() => {
    "weight": weight,
    "volume": volume
  };

  bool isValid() {
    return weight != null && volume != null;
  }
}