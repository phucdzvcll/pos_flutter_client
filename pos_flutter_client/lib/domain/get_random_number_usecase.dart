import 'package:pos_flutter_client/domain/common/either.dart';

import 'package:pos_flutter_client/domain/common/failure.dart';

import 'common/use_case.dart';
import 'random_provider.dart';

class GetRandomNumberUseCase extends BaseUseCase<EmptyInput, int> {
  final RandomProvider randomProvider;

  GetRandomNumberUseCase({required this.randomProvider});

  @override
  Future<Either<Failure, int>> executeInternal(input) async {
    return SuccessValue(randomProvider.getRandomInt());
  }
}
