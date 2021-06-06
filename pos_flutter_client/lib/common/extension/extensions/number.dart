import 'package:intl/intl.dart';

final f = new NumberFormat("#,###.00");

extension IntNullUtils on int? {
  int defaultZero() => defaultIfNull(0);

  int defaultIfNull(int defaultNumber) => this ?? defaultNumber;
}

extension DoubleNullUtils on double? {
  double defaultZero() => defaultIfNull(0.0);

  double defaultIfNull(double defaultNumber) => this ?? defaultNumber;

  String formatDouble() => f.format(this);
}
