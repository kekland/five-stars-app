class Properties {
  double weight;
  double volume;
  double price;

  Properties({this.weight, this.volume, this.price});
  Properties.fromJson(Map json) {
    this.weight = (json['weight'] as num).toDouble();
    this.volume = (json['volume'] as num).toDouble();
    this.price = (json['price'] != null)? (json['price'] as num).toDouble() : null;
  }

  Map toJson() => {
    "weight": weight,
    "volume": volume,
    "price": price,
  };

  bool isValid() {
    return weight != null && volume != null;
  }
}