part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class InitEvent extends OrderEvent {}

class FillItemEvent extends OrderEvent {
  final int id;

  FillItemEvent({required this.id});
}

class SearchEvent extends OrderEvent {
  final String value;

  SearchEvent({required this.value});
}
