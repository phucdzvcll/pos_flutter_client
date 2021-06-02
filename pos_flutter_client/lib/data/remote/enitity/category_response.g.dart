// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) {
  return CategoryResponse(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..header = json['header'] == null
      ? null
      : Header.fromJson(json['header'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['id'] as int?,
    name: json['name'] as String?,
    colorCode: json['colorCode'] as String?,
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'colorCode': instance.colorCode,
      'products': instance.products,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    id: json['id'] as int?,
    sku: json['sku'] as String?,
    name: json['name'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    thumbUrl: json['thumbUrl'] as String?,
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'price': instance.price,
      'thumbUrl': instance.thumbUrl,
    };
