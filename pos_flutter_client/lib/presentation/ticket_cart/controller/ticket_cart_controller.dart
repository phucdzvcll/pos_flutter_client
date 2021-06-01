import 'package:get/get.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/model/ticket.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_state.dart';

class TicketCartController extends GetxController {
  var ticketCartStateRx = Rx<TicketCartState>(
    TicketCartState(tickets: []),
  );
  var totalRx = Rx<TotalState>(
    TotalState(totalItem: 0, totalPrice: 0.0, tax: 0),
  );
  var _totalPrice = 0.0;
  var _totalItem = 0;
  var _tax = 0.0;
  List<Ticket> _ticketCart = [];

  void addToTicketCart(Item item) {
    _totalItem += 1;
    _totalPrice += item.price;
    _tax = _totalPrice / 10;
    totalRx.value =
        TotalState(totalItem: _totalItem, totalPrice: _totalPrice, tax: _tax);
    bool exits = false;
    for (var i = 0; i < _ticketCart.length; i++) {
      if (_ticketCart[i].item == item) {
        var amount = _ticketCart[i].amount + 1;
        var newTicket = _ticketCart[i].copyWith(amount: amount);
        _ticketCart[i] = newTicket;
        exits = true;
        break;
      }
    }
    if (!exits) {
      _ticketCart.add(Ticket(item: item, amount: 1));
    }
    ticketCartStateRx.value = TicketCartState(tickets: _ticketCart);
  }
}
