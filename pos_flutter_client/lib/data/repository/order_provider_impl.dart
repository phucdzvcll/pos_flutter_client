import 'dart:math';

import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/domain/models/order/category_entity.dart';
import 'package:pos_flutter_client/domain/models/order/model_order_entity.dart';
import 'package:pos_flutter_client/domain/repository/order_provider.dart';
import 'package:pos_flutter_client/domain/use_case/get_order_usecase.dart';

import '../remote/api_service.dart';

class OrderRepositoryImpl extends OrderRepository {
  List<CategoryEntity> randomCategories() {
    return <CategoryEntity>[
      CategoryEntity(name: "One", color: '#ffffff', id: 1),
      CategoryEntity(name: "Two", color: '#ffffff', id: 2),
      CategoryEntity(name: "Three", color: '#ffffff', id: 3),
      CategoryEntity(name: "Four", color: '#ffffff', id: 4),
    ];
  }

  List<ProductEntity> randomProducts(List<CategoryEntity> categories) {
    final _random = new Random();
    List<ProductEntity> items = [];
    for (var i = 0; i <= 30; i++) {
      var element = categories[_random.nextInt(categories.length)];
      items.add(
        ProductEntity(
          name: "item ${i + 1}",
          imgUrl: "https://picsum.photos/100/100",
          price: (_random.nextDouble() + 0.1) * 10,
          category: element,
        ),
      );
    }
    return items;
  }

  @override
  Future<GetOrderResult> getListOrder() async {
    List<ProductEntity> productsEntity = [];
    List<CategoryEntity> categoriesEntity = [];
    ApiService apiService = Get.find();
    var result = await apiService.getCategories();
    result.data!.forEach((data) {
      var categoryEntity = CategoryEntity(
          name: data.name.defaultEmpty(),
          color: data.colorCode.defaultEmpty(),
          id: data.id.defaultZero());

      data.products!.forEach((product) {
        productsEntity.add(ProductEntity(
            name: product.name.defaultEmpty(),
            imgUrl: product.thumbUrl.defaultEmpty(),
            category: categoryEntity,
            price: product.price.defaultZero()));
      });
      categoriesEntity.add(categoryEntity);
    });
    //List<CategoryEntity> categories = randomCategories();
    return GetOrderResult(
        categories: categoriesEntity, products: productsEntity);
  }
}
