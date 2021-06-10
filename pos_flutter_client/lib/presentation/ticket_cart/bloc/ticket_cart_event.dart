part of 'ticket_cart_bloc.dart';

@immutable
abstract class TicketCartEvent {}

class AddToCartEvent extends TicketCartEvent {
  final Item item;

  AddToCartEvent({required this.item});
}
