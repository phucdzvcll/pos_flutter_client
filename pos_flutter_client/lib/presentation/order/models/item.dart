class Item {
  final String name;
  final String imgUrl;
  final int categoryId;
  final double price;

  const Item(
      {required this.name,
      required this.imgUrl,
      required this.categoryId,
      required this.price});

  Item copyWith({String? name, String? imgUrl, int? category, double? cost}) {
    return Item(
        name: name ?? this.name,
        categoryId: category ?? this.categoryId,
        imgUrl: imgUrl ?? this.imgUrl,
        price: cost ?? this.price);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.runtimeType == runtimeType &&
          price == other.price &&
          categoryId == other.categoryId &&
          imgUrl == other.imgUrl &&
          name == other.name);

  @override
  int get hashCode => super.hashCode;
}
