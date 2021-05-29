import 'package:get/get.dart';
import 'package:pos_flutter_client/domain/common/use_case.dart';
import 'package:pos_flutter_client/domain/get_random_number_usecase.dart';

import 'models/counter_model.dart';
import 'models/home_state.dart';

class HomeController extends GetxController {
  final GetRandomNumberUseCase getRandomNumberUseCase = Get.find();
  var homeStateRx = Rx<HomeState>(LoadingHomeState());

  void increment() async {
    var count = await getRandomNumberUseCase.execute(EmptyInput());
    if(count.isSuccess) {
      homeStateRx.value = SuccessHomeState(counterModel: CounterModel(count: count.success));
    } else {
      homeStateRx.value = ErrorHomeState();
    }
  }
}
