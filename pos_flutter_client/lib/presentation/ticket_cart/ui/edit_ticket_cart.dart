import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/bloc/ticket_cart_bloc.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/model/ticket.dart';

class EditTicketCart extends StatefulWidget {
  final Ticket ticket;

  const EditTicketCart({Key? key, required this.ticket}) : super(key: key);

  @override
  _EditTicketCartState createState() => _EditTicketCartState();
}

class _EditTicketCartState extends State<EditTicketCart> {
  int itemAmount = 0;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemAmount = widget.ticket.amount;
    if (widget.ticket.comment != null) {
      commentController.text = widget.ticket.comment!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            widget.ticket.item.name,
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                var newTicket = widget.ticket.copyWith(
                    comment: commentController.text, amount: itemAmount);
                BlocProvider.of<TicketCartBloc>(context)
                    .add(EditTicketEvent(ticket: newTicket));
                Navigator.pop(context);
              },
              child: Text(
                "SAVE",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey[700],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Text(
              "Quantity",
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (itemAmount > 0) {
                      setState(() {
                        itemAmount -= 1;
                      });
                    }
                  },
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    itemAmount.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      itemAmount += 1;
                    });
                  },
                  child: Text("+"),
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: Text(
              "Comment",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: "Enter your comment"),
          ),
        )
      ],
    );
  }
}
