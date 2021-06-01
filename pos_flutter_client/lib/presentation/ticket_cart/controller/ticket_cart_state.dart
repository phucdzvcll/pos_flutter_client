import 'package:flutter/cupertino.dart';

import 'model/ticket.dart';

class TicketCartState {
  final List<Ticket> tickets;

  TicketCartState({required this.tickets});
}

class TotalState {
  final double totalPrice;
  final int totalItem;
  final double tax;

  TotalState(
      {required this.totalPrice, required this.totalItem, required this.tax});
}

class EditTicketCart {
  final Ticket ticket;
  final TextEditingController amountController;
  final TextEditingController? comment;
  EditTicketCart(
      {required this.ticket, required this.amountController, this.comment});
}
