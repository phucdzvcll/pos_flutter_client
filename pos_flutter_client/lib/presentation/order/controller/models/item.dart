class Item {
  final String name;
  final String imgUrl;
  final int categoryId;
  final double cost;

  const Item(
      {required this.name,
      required this.imgUrl,
      required this.categoryId,
      required this.cost});

  Item copyWith({String? name, String? imgUrl, int? category, double? cost}) {
    return Item(
        name: name ?? this.name,
        categoryId: category ?? this.categoryId,
        imgUrl: imgUrl ?? this.imgUrl,
        cost: cost ?? this.cost);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.runtimeType == runtimeType &&
          cost == other.cost &&
          categoryId == other.categoryId &&
          imgUrl == other.imgUrl &&
          name == other.name);

  @override
  int get hashCode => super.hashCode;
}
