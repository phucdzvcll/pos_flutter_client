import 'model/ticket.dart';

class TicketCartState {
  final List<Ticket> tickets;

  TicketCartState({required this.tickets});

  int totalItem() {
    var total = 0;
    tickets.forEach((element) {
      total += element.amount;
    });
    return total;
  }
}
