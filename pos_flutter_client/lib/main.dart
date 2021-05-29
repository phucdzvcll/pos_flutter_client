import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/getx_common.dart';
import 'package:pos_flutter_client/data/random_provider_impl.dart';
import 'package:pos_flutter_client/domain/get_random_number_usecase.dart';
import 'package:pos_flutter_client/domain/random_provider.dart';
import 'package:pos_flutter_client/presentation/home/controller/home_controller.dart';

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



class Home extends StatelessWidget {
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetXWrapBuilder<HomeController>(
              initController: controller,
              builder: (_) => Text(
                'clicks: ${controller.counterModelRx.value.count}',
              ),
            ),
            ElevatedButton(
              child: Text('Next Route'),
              onPressed: () {
                Get.to(
                  Second(
                    count: controller.counterModelRx.value.count,
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
