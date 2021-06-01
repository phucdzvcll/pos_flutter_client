import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_controller.dart';

class EditTicketCart extends StatelessWidget {
  final String title;
  final TicketCartController ticketCartController;

  const EditTicketCart(
      {Key? key, required this.title, required this.ticketCartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
      ),
    );
  }
}
