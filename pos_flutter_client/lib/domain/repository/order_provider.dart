import 'package:pos_flutter_client/domain/use_case/get_order_usecase.dart';

import '../domain.dart';

abstract class OrderRepository {
  Future<Either<Failure, GetOrderResult>> getListOrder();
}
