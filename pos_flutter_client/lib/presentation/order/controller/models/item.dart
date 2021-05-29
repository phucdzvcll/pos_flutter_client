import 'dart:math';

class Item {
  final String name;
  final String imgUrl;
  final double cost;

  const Item({required this.name, required this.imgUrl, required this.cost});

  Item copyWith({String? name, String? imgUrl, double? cost}) {
    return Item(
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
        cost: cost ?? this.cost);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.runtimeType == runtimeType &&
          cost == other.cost &&
          imgUrl == other.imgUrl &&
          name == other.name);

  @override
  int get hashCode => super.hashCode;
}

List<Item> providerListItem() {
  List<Item> items = [];
  Random costR = new Random();
  for (var i = 0; i <= 30; i++) {
    items.add(
      Item(
        name: "item ${i + 1}",
        imgUrl: "https://picsum.photos/100/100",
        cost: (costR.nextDouble() + 0.1) * 10,
      ),
    );
  }

  return items;
}
