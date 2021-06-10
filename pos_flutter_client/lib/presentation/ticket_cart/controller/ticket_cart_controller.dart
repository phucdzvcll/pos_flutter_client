import 'package:get/get.dart';
import 'package:pos_flutter_client/presentation/order/models/item.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_state.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/model/ticket.dart';

class TicketCartController extends GetxController {
  var ticketCartStateRx = Rx<TicketCartState>(
    TicketCartState(tickets: [], tax: 0.0),
  );
  Ticket? _oldEditTicket;
  var editTicketStateRx = Rx<EditTicketCartState>(
    EditTicketCartState(
      ticket: Ticket(
          item: Item(
            categoryId: 0,
            name: "",
            imgUrl: "",
            price: 0,
          ),
          amount: 0),
    ),
  );
  List<Ticket> _ticketCart = [];

  void addToTicketCart(Item item) {
    var index = _ticketCart.indexWhere((element) => element.item == item);
    bool exists = index >= 0;
    if (exists) {
      var amount = _ticketCart[index].amount + 1;
      var newTicket = _ticketCart[index].copyWith(amount: amount);
      _ticketCart[index] = newTicket;
    } else {
      _ticketCart.add(Ticket(item: item, amount: 1));
    }

    ticketCartStateRx.value =
        ticketCartStateRx.value.copyWith(tickets: _ticketCart);
  }

  void edit(Ticket ticket) {
    _oldEditTicket = ticket;
    editTicketStateRx.value = EditTicketCartState(
      ticket: ticket.copyWith(),
    );
  }

  void upAction() {
    var amount = editTicketStateRx.value.ticket.amount + 1;
    var newTicket = editTicketStateRx.value.ticket.copyWith(amount: amount);
    editTicketStateRx.value = EditTicketCartState(
      ticket: newTicket,
    );
  }

  void downAction() {
    var amount = editTicketStateRx.value.ticket.amount;
    if (editTicketStateRx.value.ticket.amount > 0) {
      amount -= 1;
    }
    var newTicket = editTicketStateRx.value.ticket.copyWith(amount: amount);
    editTicketStateRx.value = EditTicketCartState(
      ticket: newTicket,
    );
  }

  void saveEdit() {
    if (_oldEditTicket != null) {
      var index =
          _ticketCart.indexWhere((element) => element == _oldEditTicket);
      if (index >= 0) {
        if (editTicketStateRx.value.ticket.amount == 0) {
          _ticketCart.removeAt(index);
        } else {
          _ticketCart[index] = editTicketStateRx.value.ticket;
        }
        ticketCartStateRx.value =
            ticketCartStateRx.value.copyWith(tickets: _ticketCart);
      }
    }
  }
}
