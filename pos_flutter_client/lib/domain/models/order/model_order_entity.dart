import 'dart:math';

class ModelOrderEntity {
  final String name;
  final String imgUrl;
  final String category;
  final double cost;

  const ModelOrderEntity(
      {required this.category,
      required this.name,
      required this.imgUrl,
      required this.cost});

  ModelOrderEntity copyWith(
      {String? name, String? imgUrl, String? category, double? cost}) {
    return ModelOrderEntity(
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
        category: category ?? this.category,
        cost: cost ?? this.cost);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelOrderEntity &&
          other.runtimeType == runtimeType &&
          cost == other.cost &&
          category == other.category &&
          imgUrl == other.imgUrl &&
          name == other.name);

  @override
  int get hashCode => super.hashCode;
}

List<ModelOrderEntity> providerListItem() {
  List<ModelOrderEntity> items = [];
  Random costR = new Random();
  for (var i = 0; i <= 30; i++) {
    items.add(
      ModelOrderEntity(
        name: "item ${i + 1}",
        category: "",
        imgUrl: "https://picsum.photos/100/100",
        cost: (costR.nextDouble() + 0.1) * 10,
      ),
    );
  }

  return items;
}
