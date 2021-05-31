extension IntNullUtils on int? {
  int defaultZero() => defaultIfNull(0);
  int defaultIfNull(int defaultNumber) => this ?? defaultNumber;
}

extension DoubleNullUtils on double? {
  double defaultZero() => defaultIfNull(0.0);
  double defaultIfNull(double defaultNumber) => this ?? defaultNumber;
}