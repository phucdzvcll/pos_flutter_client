import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Order extends StatelessWidget {
  Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
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
        body: _body(dropdownValue, context),
      ),
    );
  }

  List<String> category = [];

  Widget _body(String _dropdownValue, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: _butonnOrder(),
        ),
        _dropMenuCategory(_dropdownValue),
      ],
    );
  }

  Container _dropMenuCategory(String _dropdownValue) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton(
                value: _dropdownValue,
                underline: Container(
                  color: Color(0x00000000),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.expand_more_outlined,
                  ),
                ),
                iconSize: 24,
                isExpanded: true,
                style: const TextStyle(color: Colors.black),
                onChanged: (newValue) {
                  //send value
                },
                items: ['One', 'Two', 'Free', 'Four']
                    .map((category) => DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              category,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          value: category,
                        ))
                    .toList()),
          ),
          Container(
            decoration: BoxDecoration(
                border:
                    Border.symmetric(vertical: BorderSide(color: Colors.grey))),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          )
        ],
      ),
    );
  }

  Row _butonnOrder() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff7CB342),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              onPressed: () {},
              child: Text("SAVE"),
            ),
          ),
        ),
        Expanded(
            child: SizedBox(
          height: 70,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xff7CB342),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
            onPressed: () {},
            child: Text("CHARGE"),
          ),
        )),
      ],
    );
  }
}
