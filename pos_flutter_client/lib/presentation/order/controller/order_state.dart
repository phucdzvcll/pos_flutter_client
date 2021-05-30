import 'package:pos_flutter_client/presentation/order/controller/models/category.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';

abstract class OrderItemsState {}

class LoadingOrderState extends OrderItemsState {}

class SuccessOrderState extends OrderItemsState {
  final List<Item> items;

  SuccessOrderState({required this.items});
}

class ErrorOrderState extends OrderItemsState {}

class CategoriesState {
  final List<Category> categories;
  final int selectedCategoryId;

  const CategoriesState({
    required this.categories,
    required this.selectedCategoryId,
  });
}
