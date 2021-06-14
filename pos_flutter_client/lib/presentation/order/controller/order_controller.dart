import 'package:get/get.dart';
import 'package:pos_flutter_client/domain/domain.dart';
import 'package:pos_flutter_client/presentation/home/controller/authentication_controller.dart';
import 'package:pos_flutter_client/presentation/order/order.dart';

class OrderController extends GetxController {
  final GetOrderUseCase getOrderUseCase = Get.find();
  final authenticationController = Get.find<AuthenticationController>();
  var fillBarRX = Rx<FillBarState>(FillState());
  var orderStateRx = Rx<OrderItemsState>(LoadingOrderState());
  var categoryRx = Rx<CategoriesState>(CategoriesState(
      categories: [Category(name: "All", color: '#ffffff', id: 0)],
      selectedCategoryId: 0));
  List<Item> _items = [];
  List<Category> _categories = [];
  int _currentCategoryId = 0;

  void getListOrders() async {
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
      orderStateRx.value = SuccessOrderState(items: _items);
    } else {
      orderStateRx.value = ErrorOrderState();
    }
    categoryRx.value =
        CategoriesState(categories: _categories, selectedCategoryId: 0);
  }

  void fillByCategory(int id) async {
    if (id == 0) {
      _currentCategoryId = 0;
      orderStateRx.value = SuccessOrderState(items: _items.toList());
    } else {
      _currentCategoryId = id;
      orderStateRx.value = SuccessOrderState(
          items: _items.where((item) => item.categoryId == id).toList());
    }
    categoryRx.value =
        CategoriesState(categories: _categories, selectedCategoryId: id);
  }

  void fillBySearch(String value) {
    if (_currentCategoryId == 0) {
      orderStateRx.value = SuccessOrderState(
          items: _items
              .where((item) => item.name.toLowerCase().contains(value))
              .toList());
    } else {
      orderStateRx.value = SuccessOrderState(
          items: _items
              .where((item) => (item.categoryId == _currentCategoryId &&
                  item.name.toLowerCase().contains(value)))
              .toList());
    }
  }

  void changeFillBarState() {
    if (fillBarRX.value is FillState) {
      fillBarRX.value = SearchState();
    } else {
      fillBarRX.value = FillState();
      fillByCategory(_currentCategoryId);
    }
  }

  void logout() {
    authenticationController.logout();
  }
}
