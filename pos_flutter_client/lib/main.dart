import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/data/data.dart';
import 'package:pos_flutter_client/data/remote/api_service.dart';
import 'package:pos_flutter_client/domain/domain.dart';
import 'package:pos_flutter_client/presentation/home/controller/authentication_controller.dart';
import 'package:pos_flutter_client/presentation/home/home_state.dart';
import 'package:pos_flutter_client/presentation/home/ui/home_page.dart';
import 'package:pos_flutter_client/presentation/order/ui/order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance;
  // DI
  _initDi();

  runApp(MyApp());
}

void _initDi() {
  //data
  //singleton
  final BaseOptions baseOptions = BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
    responseType: ResponseType.json,
  );
  final dio = Dio(baseOptions); // Provide a dio instance
  final client = ApiService(dio);
  Get.put<OrderRepository>(OrderRepositoryImpl());
  Get.put<RandomProvider>(RandomProviderImpl());
  Get.put<ApiService>(client);

  //domain
  //factory
  Get.create<GetOrderUseCase>(
      () => GetOrderUseCase(orderRepository: Get.find()));
  Get.create<GetRandomNumberUseCase>(
      () => GetRandomNumberUseCase(randomProvider: Get.find()));
}

class MyApp extends StatelessWidget {
  final AuthenticationController authenticationController =
      AuthenticationController()..getAuthenticationState();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: GetXWrapBuilder(
        builder: (_) => _authenticationBuilder(
            authenticationController.authenticationRx.value),
        initController: authenticationController,
      ),
    );
  }

  Widget _authenticationBuilder(AuthenticationState authenticationState) {
    if (authenticationState is LoginState) {
      return Order(
        email: authenticationState.email,
      );
    } else if (authenticationState is LogoutState) {
      return HomePage();
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
//
// class Home extends StatelessWidget {
//   final HomeController controller = HomeController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("counter")),
//       body: GetXWrapBuilder<HomeController>(
//         initController: controller,
//         builder: (_) => _buildState(controller.homeStateRx.value),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => {controller.increment()},
//       ),
//     );
//   }
//
//   Widget _buildState(HomeState homeState) {
//     if (homeState is LoadingHomeState) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     } else if (homeState is SuccessHomeState) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'clicks: ${homeState.counterModel.count}',
//             ),
//             ElevatedButton(
//               child: Text('Next Route'),
//               onPressed: () {
//                 Get.to(
//                   Second(
//                     count: homeState.counterModel.count,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Center(
//         child: Text("Error!"),
//       );
//     }
//   }
// }
//
// class Second extends StatelessWidget {
//   final int count;
//
//   const Second({Key? key, required this.count}) : super(key: key);
//
//   @override
//   Widget build(context) {
//     return Scaffold(body: Center(child: Text("$count")));
//   }
// }
