import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pos_flutter_client/domain/common/use_case.dart';
import 'package:pos_flutter_client/domain/use_case/get_order_usecase.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/category.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/order_state.dart';

import 'models/item.dart';

class OrderController extends GetxController {
  final GetOrderUseCase getOrderUseCase = Get.find();
  var orderStateRx = Rx<OrderState>(LoadingOrderState());
  var categoryRx = Rx<Category>(Category(name: "One"));
  List<Item> items = [];

  void getListOrders() async {
    var result = await getOrderUseCase.execute(EmptyInput());
    items = result.success
        .map((orderModelEntity) => Item(
              imgUrl: orderModelEntity.imgUrl,
              category: orderModelEntity.category,
              cost: orderModelEntity.cost,
              name: orderModelEntity.name,
            ))
        .toList();
    if (result.isSuccess) {
      orderStateRx.value = SuccessOrderState(items: items);
    } else {
      orderStateRx.value = ErrorOrderState();
    }
  }

  void fillByCategory(String? category) async {
    if (items.isEmpty) {
      var result = await getOrderUseCase.execute(EmptyInput());
      items = result.success
          .map((orderModelEntity) => Item(
                imgUrl: orderModelEntity.imgUrl,
                category: orderModelEntity.category,
                cost: orderModelEntity.cost,
                name: orderModelEntity.name,
              ))
          .toList();
      if (result.isSuccess) {
        orderStateRx.value = SuccessOrderState(
            items: items.where((item) => item.category == category).toList());
      } else {
        orderStateRx.value = ErrorOrderState();
      }
    } else {
      orderStateRx.value = SuccessOrderState(
          items: items.where((item) => item.category == category).toList());
    }
    categoryRx.value = Category(name: category ?? "One");
  }
}
