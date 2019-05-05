class Volume {
  double _baseVolumeCubicMeters;

  Volume({double cubicMeter = 0.0, double cubicCentimeter = 0.0, double cubicMillimeter = 0.0, double liter = 0.0}) {
    //baseWeightKilograms = (ton * 1e3) + kilogram + (gram / 1e3) + (milligram / 1e6);
    _baseVolumeCubicMeters = (cubicMeter) + (cubicCentimeter / 1e6) + (cubicMillimeter / 1e9) + (liter / 1e3);
  }

  double get cubicMeter => _baseVolumeCubicMeters;
  double get cubicCentimeter => _baseVolumeCubicMeters * 1e6;
  double get cubicMillimeter => _baseVolumeCubicMeters * 1e9;
  double get liter => _baseVolumeCubicMeters * 1e3;
}