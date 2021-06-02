import 'package:intl/intl.dart';

final f = new NumberFormat("###");

extension IntNullUtils on int? {
  int defaultZero() => defaultIfNull(0);

  int defaultIfNull(int defaultNumber) => this ?? defaultNumber;
}

extension DoubleNullUtils on double? {
  double defaultZero() => defaultIfNull(0.0);

  double defaultIfNull(double defaultNumber) => this ?? defaultNumber;

  String formatDouble() {
    if (this.defaultZero().truncateToDouble() == this) {
      return f.format(this);
    } else {
      return this.defaultZero().toString();
    }
  }
}
