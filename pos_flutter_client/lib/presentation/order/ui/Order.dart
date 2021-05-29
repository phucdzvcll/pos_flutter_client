import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4CAF50),
        title: InkWell(
          onTap: () {
            //move to ticket screen
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Ticket"),
              SizedBox(
                width: 10,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'images/ic_receipt.svg',
                    width: 25,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                  Text(
                    "5",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.person_add_outlined,
              ),
              onPressed: () {}),
          IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.more_vert_outlined,
              ),
              onPressed: () {}),
        ],
        leading: IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(
              Icons.view_headline_outlined,
            ),
            onPressed: () {}),
      ),
    ));
  }
}
