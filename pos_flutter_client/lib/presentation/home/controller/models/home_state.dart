import 'package:pos_flutter_client/presentation/home/controller/models/counter_model.dart';

abstract class HomeState {}

class LoadingHomeState extends HomeState {}

class SuccessHomeState extends HomeState {
  final CounterModel counterModel;

  SuccessHomeState({required this.counterModel});
}

class ErrorHomeState extends HomeState {}