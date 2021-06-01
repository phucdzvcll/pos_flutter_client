import 'package:get/get.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/model/ticket.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_state.dart';

class TicketCartController extends GetxController {
  var ticketCartStateRx = Rx<TicketCartState>(TicketCartState(tickets: []));

  void itemsCart(List<Item> items) async {
    var mapData = Map();
    items.forEach((element) {
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
}
