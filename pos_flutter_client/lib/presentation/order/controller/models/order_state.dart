import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';

abstract class OrderState {}

class LoadingOrderState extends OrderState {}

class SuccessOrderState extends OrderState {
  final List<Item> items;

  SuccessOrderState({required this.items});
}

class ErrorOrderState extends OrderState {}
