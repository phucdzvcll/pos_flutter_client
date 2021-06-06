import '../controller/models/category.dart';
import '../controller/models/item.dart';

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

class FillBarState {}

class SearchState extends FillBarState {}

class FillState extends FillBarState {}
