part of 'ticket_cart_bloc.dart';

@immutable
abstract class TicketCartBlocState {}

class TicketCartInitial extends TicketCartBlocState {}

class TicketState extends TicketCartBlocState {
  final List<Ticket> tickets = [];
  final double tax;

  TicketState({required this.tax, required List<Ticket> tickets}) {
    this.tickets.addAll(tickets);
  }

  int getCountItem() {
    var count = 0;
    tickets.forEach((element) {
      count += element.amount;
    });
    return count;
  }

  double getTotalPrice() {
    var total = 0.0;
    tickets.forEach((element) {
      total += element.amount * element.item.price;
    });
    return total;
  }

  double getCartAmount() {
    return getTotalPrice() + tax;
  }

//<editor-fold desc="Data Methods" defaultstate="collapsed">
  @override
  String toString() {
    return 'TicketCartState{tickets: $tickets, tax: $tax}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TicketState &&
          runtimeType == other.runtimeType &&
          tickets == other.tickets &&
          tax == other.tax);

  @override
  int get hashCode => tickets.hashCode ^ tax.hashCode;

//</editor-fold>

}
