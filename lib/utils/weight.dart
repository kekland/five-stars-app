class Weight {
  double _baseWeightKilograms;

  Weight({double ton = 0.0, double kilogram = 0.0, double gram = 0.0, double milligram = 0.0}) {
    _baseWeightKilograms = (ton * 1e3) + (kilogram) + (gram / 1e3) + (milligram / 1e6);
  }

  double get ton => _baseWeightKilograms / 1e3;
  double get kilogram => _baseWeightKilograms;
  double get gram => _baseWeightKilograms * 1e3;
  double get milligram => _baseWeightKilograms * 1e6;
  
  operator ==(other) => (other is Weight) && (this._baseWeightKilograms == other._baseWeightKilograms);
  operator >(other) => (other is Weight) && (this._baseWeightKilograms > other._baseWeightKilograms);
  operator <(other) => (other is Weight) && (this._baseWeightKilograms < other._baseWeightKilograms);
  operator <=(other) => (other is Weight) && (this._baseWeightKilograms <= other._baseWeightKilograms);
  operator >=(other) => (other is Weight) && (this._baseWeightKilograms >= other._baseWeightKilograms);
  
  int get hashCode => _baseWeightKilograms.hashCode;
}