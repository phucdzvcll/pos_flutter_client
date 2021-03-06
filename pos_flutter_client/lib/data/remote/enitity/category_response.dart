import 'package:json_annotation/json_annotation.dart';
import 'package:pos_flutter_client/data/remote/wrapped_response.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse extends WrappedResponse {
  final List<Data>? data;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  @override
  String toString() {
    return 'CategoryResponse{header: $header, data: $data}';
  }

  CategoryResponse({required this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);

//</editor-fold>

}

@JsonSerializable()
class Data {
  final int? id;
  final String? name;
  final String? colorCode;
  final List<Products>? products;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  @override
  String toString() {
    return 'Data{id: $id, name: $name, colorCode: $colorCode, products: $products}';
  }

  Data(
      {required this.id,
      required this.name,
      required this.colorCode,
      required this.products});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
//</editor-fold>

}

@JsonSerializable()
class Products {
  final int? id;
  final String? sku;
  final String? name;
  final double? price;
  final String? thumbUrl;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  @override
  String toString() {
    return 'Products{id: $id, sku: $sku, name: $name, price: $price, thumbUrl: $thumbUrl}';
  }

  Products(
      {required this.id,
      required this.sku,
      required this.name,
      required this.price,
      required this.thumbUrl});

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

//</editor-fold>

}
