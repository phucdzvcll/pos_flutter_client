class CounterModel {
  final int count;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const CounterModel({
    required this.count,
  });

  CounterModel copyWith({
    int? count,
  }) {
    return new CounterModel(
      count: count ?? this.count,
    );
  }

  @override
  String toString() {
    return 'CounterModel{count: $count}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CounterModel &&
          runtimeType == other.runtimeType &&
          count == other.count);

  @override
  int get hashCode => count.hashCode;

//</editor-fold>

}
