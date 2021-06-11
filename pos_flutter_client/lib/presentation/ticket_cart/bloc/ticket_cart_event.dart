part of 'ticket_cart_bloc.dart';

@immutable
abstract class TicketCartEvent {}

class AddToCartEvent extends TicketCartEvent {
  final Item item;

  AddToCartEvent({required this.item});
}

class EditTicketEvent extends TicketCartEvent {
  final Ticket ticket;

  EditTicketEvent({required this.ticket});
}

class ClearEvent extends TicketCartEvent {}
