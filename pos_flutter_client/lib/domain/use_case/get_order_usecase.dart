import 'package:pos_flutter_client/domain/common/either.dart';
import 'package:pos_flutter_client/domain/common/failure.dart';
import 'package:pos_flutter_client/domain/models/order/model_order_entity.dart';
import 'package:pos_flutter_client/domain/provider/order_provider.dart';

import '../common/use_case.dart';

class GetOrderUseCase extends BaseUseCase<EmptyInput, List<ModelOrderEntity>> {
  final OrderProvider orderProvider;

  GetOrderUseCase({required this.orderProvider});

  @override
  Future<Either<Failure, List<ModelOrderEntity>>> executeInternal(
      EmptyInput input) async {
    return SuccessValue(orderProvider.getListOrder());
  }
}
