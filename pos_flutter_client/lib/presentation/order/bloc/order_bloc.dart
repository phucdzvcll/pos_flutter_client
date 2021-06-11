import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_client/domain/common/use_case.dart';
import 'package:pos_flutter_client/domain/use_case/get_order_usecase.dart';
import 'package:pos_flutter_client/presentation/order/models/category.dart';
import 'package:pos_flutter_client/presentation/order/models/item.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(LoadingOrderState());
  final GetOrderUseCase getOrderUseCase = Get.find();
  List<Item> _items = [];
  List<Category> _categories = [];
  int _currentCategoryId = 0;

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is InitEvent) {
      yield* _handleGetListItem();
    } else if (event is FillItemEvent) {
      yield* _handleFillItem(event);
    } else if (event is SearchEvent) {
      yield* _handleSearch(event.value.toLowerCase());
    }
  }

  Stream<OrderState> _handleSearch(String value) async* {
    if (_currentCategoryId == 0) {
      yield SuccessOrderState(
          items: _items
              .where((item) => item.name.toLowerCase().contains(value))
              .toList(),
          categoriesState: CategoriesState(
              categories: _categories, selectedCategoryId: _currentCategoryId));
    } else {
      yield SuccessOrderState(
          items: _items
              .where((item) => (item.categoryId == _currentCategoryId &&
                  item.name.toLowerCase().contains(value)))
              .toList(),
          categoriesState: CategoriesState(
              categories: _categories, selectedCategoryId: _currentCategoryId));
    }
  }

  Stream<OrderState> _handleFillItem(FillItemEvent event) async* {
    if (event.id == 0) {
      _currentCategoryId = 0;
      yield SuccessOrderState(
          items: _items.toList(),
          categoriesState:
              CategoriesState(categories: _categories, selectedCategoryId: 0));
    } else {
      _currentCategoryId = event.id;
      yield SuccessOrderState(
          items: _items.where((item) => item.categoryId == event.id).toList(),
          categoriesState: CategoriesState(
              categories: _categories, selectedCategoryId: event.id));
    }
  }

  Stream<OrderState> _handleGetListItem() async* {
    _items.clear();
    _categories.clear();
    _categories.add(Category(name: "All", color: '#ffffff', id: 0));
    var result = await getOrderUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      _items = result.success.products
          .map((orderModelEntity) => Item(
                imgUrl: orderModelEntity.imgUrl,
                categoryId: orderModelEntity.category.id,
                price: orderModelEntity.price,
                name: orderModelEntity.name,
              ))
          .toList();
      var categoriesResult = result.success.categories
          .map((category) => Category(
              name: category.name, color: category.color, id: category.id))
          .toList();
      _categories.addAll(categoriesResult);
      yield SuccessOrderState(
          items: _items,
          categoriesState:
              CategoriesState(categories: _categories, selectedCategoryId: 0));
    } else {
      yield ErrorOrderState();
    }
  }
}
