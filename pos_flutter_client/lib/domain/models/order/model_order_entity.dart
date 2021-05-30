import 'package:pos_flutter_client/domain/models/order/category_entity.dart';

class ProductEntity {
  final String name;
  final String imgUrl;
  final CategoryEntity category;
  final double price;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const ProductEntity({
    required this.name,
    required this.imgUrl,
    required this.category,
    required this.price,
  });

  ProductEntity copyWith({
    String? name,
    String? imgUrl,
    CategoryEntity? category,
    double? price,
  }) {
    if ((name == null || identical(name, this.name)) &&
        (imgUrl == null || identical(imgUrl, this.imgUrl)) &&
        (category == null || identical(category, this.category)) &&
        (price == null || identical(price, this.price))) {
      return this;
    }

    return new ProductEntity(
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'ProductEntity{name: $name, imgUrl: $imgUrl, category: $category, price: $price}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          imgUrl == other.imgUrl &&
          category == other.category &&
          price == other.price);

  @override
  int get hashCode =>
      name.hashCode ^ imgUrl.hashCode ^ category.hashCode ^ price.hashCode;

//</editor-fold>

}
