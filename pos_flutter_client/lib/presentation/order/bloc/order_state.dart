part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class LoadingOrderState extends OrderState {}

class SuccessOrderState extends OrderState {
  final List<Item> items;
  final CategoriesState categoriesState;
  SuccessOrderState({required this.items, required this.categoriesState});
}

class ErrorOrderState extends OrderState {}

class CategoriesState {
  final List<Category> categories;
  final int selectedCategoryId;

  const CategoriesState({
    required this.categories,
    required this.selectedCategoryId,
  });
}
