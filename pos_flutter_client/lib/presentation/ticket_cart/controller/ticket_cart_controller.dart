import 'package:get/get.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';
import 'package:pos_flutter_client/presentation/order/controller/order_state.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/model/ticket.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_state.dart';

class TicketCartController extends GetxController {
  var ticketCartStateRx = Rx<TicketCartState>(TicketCartState(tickets: []));
  var ticketCartRx = Rx<TicketState>(TicketState(items: []));
  List<Item> _ticketCartItems = [];
  void itemsCart() async {
    var mapData = Map();
    _ticketCartItems.forEach((element) {
      if (!mapData.containsKey(element)) {
        mapData[element] = 1;
      } else {
        mapData[element] += 1;
      }
    });
    List<Ticket> listTicket = mapData.entries
        .map((e) => Ticket(item: e.key, amount: e.value))
        .toList();
    ticketCartStateRx.value = TicketCartState(tickets: listTicket);
  }

  void addToTicketCart(Item item) {
    _ticketCartItems.add(item);
    ticketCartRx.value = TicketState(items: _ticketCartItems);
  }
}
