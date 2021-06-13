import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/data/data.dart';
import 'package:pos_flutter_client/data/remote/api_service.dart';
import 'package:pos_flutter_client/domain/domain.dart';
import 'package:pos_flutter_client/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:pos_flutter_client/presentation/authentication/ui/authentication.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/bloc/ticket_cart_bloc.dart';

import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  // DI
  _initDi();

  //flutter pub run easy_localization:generate --source-dir ./assets/translations
  //flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
  //flutter pub run build_runner build --delete-conflicting-outputs
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('vi')],
        path: 'assets/translations',
        startLocale: Locale('en'),
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) {
              return AuthenticationBloc()..add(InitAuthenticationEvent());
            },
          ),
          BlocProvider<TicketCartBloc>(create: (_) {
            return TicketCartBloc();
          })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: {'/': (context) => Authentication()},
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
        ));
  }
}
