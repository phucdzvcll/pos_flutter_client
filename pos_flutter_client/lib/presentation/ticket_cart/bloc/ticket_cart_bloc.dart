import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_client/presentation/order/order.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/model/ticket.dart';

part 'ticket_cart_event.dart';
part 'ticket_cart_state.dart';

class TicketCartBloc extends Bloc<TicketCartEvent, TicketCartBlocState> {
  TicketCartBloc() : super(TicketState(tax: 0.0, tickets: []));
  List<Ticket> _ticketCart = [];
  TicketState ticketState = TicketState(tax: 0.0, tickets: []);

  Ticket? _oldEditTicket;

  void edit(Ticket ticket) {
    _oldEditTicket = ticket;
  }

  @override
  Stream<TicketCartBlocState> mapEventToState(
    TicketCartEvent event,
  ) async* {
    if (event is AddToCartEvent) {
      var index =
          _ticketCart.indexWhere((element) => element.item == event.item);
      bool exists = index >= 0;
      if (exists) {
        var amount = _ticketCart[index].amount + 1;
        var newTicket = _ticketCart[index].copyWith(amount: amount);
        _ticketCart[index] = newTicket;
      } else {
        _ticketCart.add(Ticket(item: event.item, amount: 1));
      }
      ticketState = ticketState.copyWith(tickets: _ticketCart);
      yield ticketState;
    } else if (event is EditTicketEvent) {
      if (_oldEditTicket != null) {
        var index =
            _ticketCart.indexWhere((element) => element == _oldEditTicket);
        if (index >= 0) {
          if (event.ticket.amount == 0) {
            _ticketCart.removeAt(index);
          } else {
            _ticketCart[index] = event.ticket;
          }
          ticketState = ticketState.copyWith(tickets: _ticketCart);
          yield ticketState;
        }
      }
    }
  }
}
