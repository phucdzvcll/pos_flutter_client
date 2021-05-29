import 'random_provider.dart';

class GetRandomNumberUseCase {
  final RandomProvider randomProvider;

  GetRandomNumberUseCase({required this.randomProvider});

  Future<int> run() async {
    return randomProvider.getRandomInt();
  }
}
