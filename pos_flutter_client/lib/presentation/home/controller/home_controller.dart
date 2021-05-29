import 'package:get/get.dart';
import 'package:pos_flutter_client/domain/get_random_number_usecase.dart';
import 'package:pos_flutter_client/presentation/home/controller/models/counter_model.dart';

class HomeController extends GetxController {
  final GetRandomNumberUseCase getRandomNumberUseCase = Get.find();
  var counterModelRx = CounterModel(count: 0).obs;

  void increment() async {
    var count = await getRandomNumberUseCase.run();
    counterModelRx.value = counterModelRx.value.copyWith(count: count);
  }
}