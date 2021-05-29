import 'dart:math';

class Item {
  final String name;
  final String imgUrl;
  final double cost;

  Item({required this.name, required this.imgUrl, required this.cost});
}

List<Item> providerListItem() {
  List<Item> items = [];
  Random costR = new Random();
  for (var i = 0; i <= 30; i++) {
    items.add(Item(
        name: "item ${i + 1}",
        imgUrl: "https://picsum.photos/100/100",
        cost: costR.nextDouble().truncateToDouble()));
  }

  return items;
}
