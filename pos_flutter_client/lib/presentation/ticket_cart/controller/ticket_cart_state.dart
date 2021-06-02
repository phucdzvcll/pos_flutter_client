import 'model/ticket.dart';

class TicketCartState {
  final List<Ticket> tickets;
  final double tax;

  TicketCartState({required this.tax, required this.tickets});

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
  TicketCartState copyWith({
    List<Ticket>? tickets,
    double? tax,
  }) {
    List<Ticket>? list;
    if (tickets != null) {
      list = List.of(tickets);
    }
    return new TicketCartState(
      tickets: list ?? this.tickets,
      tax: tax ?? this.tax,
    );
  }

  @override
  String toString() {
    return 'TicketCartState{tickets: $tickets, tax: $tax}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TicketCartState &&
          runtimeType == other.runtimeType &&
          tickets == other.tickets &&
          tax == other.tax);

  @override
  int get hashCode => tickets.hashCode ^ tax.hashCode;

//</editor-fold>

}

class EditTicketCartState {
  final Ticket ticket;

  EditTicketCartState({required this.ticket});
}
