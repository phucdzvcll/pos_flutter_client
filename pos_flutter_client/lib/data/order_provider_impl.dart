import 'dart:math';

import 'package:pos_flutter_client/domain/models/order/model_order_entity.dart';
import 'package:pos_flutter_client/domain/provider/order_provider.dart';

class OrderProviderImpl extends OrderProvider {
  @override
  List<ModelOrderEntity> getListOrder() {
    return moderOrders();
  }

  List<ModelOrderEntity> moderOrders() {
    var listCategories = ['One', 'Two', 'Three', 'Four'];
    final _random = new Random();
    List<ModelOrderEntity> items = [];
    Random costR = new Random();
    for (var i = 0; i <= 30; i++) {
      var element = listCategories[_random.nextInt(listCategories.length)];
      items.add(
        ModelOrderEntity(
          name: "item ${i + 1}",
          imgUrl: "https://picsum.photos/100/100",
          cost: (costR.nextDouble() + 0.1) * 10,
          category: element,
        ),
      );
    }
    return items;
  }
}
