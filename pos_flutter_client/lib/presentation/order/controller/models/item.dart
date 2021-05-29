class Item {
  final String name;
  final String imgUrl;
  final String category;
  final double cost;

  const Item(
      {required this.name,
      required this.imgUrl,
      required this.category,
      required this.cost});

  Item copyWith(
      {String? name, String? imgUrl, String? category, double? cost}) {
    return Item(
        name: name ?? this.name,
        category: category ?? this.category,
        imgUrl: imgUrl ?? this.imgUrl,
        cost: cost ?? this.cost);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.runtimeType == runtimeType &&
          cost == other.cost &&
          category == other.category &&
          imgUrl == other.imgUrl &&
          name == other.name);

  @override
  int get hashCode => super.hashCode;
}
