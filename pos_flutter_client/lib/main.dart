import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/getx_common.dart';
import 'package:pos_flutter_client/data/random_provider_impl.dart';
import 'package:pos_flutter_client/domain/get_random_number_usecase.dart';
import 'package:pos_flutter_client/domain/random_provider.dart';

void main() {
  // DI
  _initDi();

  runApp(MyApp());
}

void _initDi() {
  //data
  //singleton
  Get.put<RandomProvider>(RandomProviderImpl());

  //domain
  //factory
  Get.create<GetRandomNumberUseCase>(() => GetRandomNumberUseCase(randomProvider: Get.find()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Controller extends GetxController {
  final GetRandomNumberUseCase getRandomNumberUseCase = Get.find();
  var count = 0.obs;

  void increment() async {
    count.value = await getRandomNumberUseCase.run();
  }
}

class Home extends StatelessWidget {
  final Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetXWrapBuilder<Controller>(
              initController: controller,
              builder: (_) => Text(
                'clicks: ${controller.count}',
              ),
            ),
            ElevatedButton(
              child: Text('Next Route'),
              onPressed: () {
                Get.to(
                  Second(
                    count: controller.count.value,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {controller.increment()},
      ),
    );
  }
}

class Second extends StatelessWidget {
  final int count;

  const Second({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(body: Center(child: Text("$count")));
  }
}
