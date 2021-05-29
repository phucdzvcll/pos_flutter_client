import 'package:pos_flutter_client/domain/models/order/model_order_entity.dart';

abstract class OrderProvider {
  List<ModelOrderEntity> getListOrder();
}
