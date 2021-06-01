import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_controller.dart';

class EditTicketCart extends StatelessWidget {
  final TicketCartController ticketCartController;

  const EditTicketCart({Key? key, required this.ticketCartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: GetXWrapBuilder(
            initController: ticketCartController,
            builder: (_) => Text(
              ticketCartController.editTicketState.value.ticket.item.name,
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
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
              Get.back();
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
                  onPressed: () {},
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GetXWrapBuilder(
                  initController: ticketCartController,
                  builder: (_) => TextField(
                    controller: ticketCartController
                        .editTicketState.value.amountController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      ticketCartController
                          .editTicketState.value.amountController.text = value;
                    },
                  ),
                ),
              )),
              SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
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
          child: GetXWrapBuilder(
            initController: ticketCartController,
            builder: (_) => TextField(
              controller: ticketCartController.editTicketState.value.comment,
              decoration: InputDecoration(hintText: "Enter your comment"),
            ),
          ),
        )
      ],
    );
  }
}
