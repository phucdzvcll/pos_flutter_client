import 'package:pos_flutter_client/domain/common/either.dart';
import 'package:pos_flutter_client/domain/common/failure.dart';
import 'package:pos_flutter_client/domain/models/order/category_entity.dart';
import 'package:pos_flutter_client/domain/models/order/model_order_entity.dart';
import 'package:pos_flutter_client/domain/repository/order_provider.dart';

import '../common/use_case.dart';

class GetOrderUseCase extends BaseUseCase<EmptyInput, GetOrderResult> {
  final OrderRepository orderRepository;

  GetOrderUseCase({required this.orderRepository});

  @override
  Future<Either<Failure, GetOrderResult>> executeInternal(
      EmptyInput input) async {
    return await orderRepository.getListOrder();
  }
}

class GetOrderResult {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  GetOrderResult({required this.products, required this.categories});
}
