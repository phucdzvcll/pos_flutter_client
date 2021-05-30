import 'package:pos_flutter_client/domain/use_case/get_order_usecase.dart';

abstract class OrderRepository {
  Future<GetOrderResult> getListOrder();
}
