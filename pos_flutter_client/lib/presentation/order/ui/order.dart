import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_flutter_client/common/getx_common.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/category.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';
import 'package:pos_flutter_client/presentation/order/controller/models/order_state.dart';
import 'package:pos_flutter_client/presentation/order/controller/order_controller.dart';

class Order extends StatelessWidget {
  final OrderController orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    orderController.getListOrders();
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
        body: _body(context, orderController),
      ),
    );
  }

  Widget _body(BuildContext context, OrderController orderController) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: _buttonOrder(),
        ),
        GetXWrapBuilder<OrderController>(
            initController: orderController,
            builder: (_) => _dropDown(orderController.categoryRx.value)),
        Expanded(
          child: GetXWrapBuilder<OrderController>(
            initController: orderController,
            builder: (_) => _buildState(orderController.orderStateRx.value),
          ),
        )
      ],
    );
  }

  _buildState(OrderState orderState) {
    if (orderState is LoadingOrderState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (orderState is SuccessOrderState) {
      return ListView(
        children: orderState.items.map((item) => itemOrder(item)).toList(),
      );
    } else {
      return Center(
        child: Text("Error"),
      );
    }
  }

  Color _categoryColor(String categoryName) {
    if (categoryName == "One") {
      return Colors.red;
    } else if (categoryName == "Two") {
      return Colors.blue;
    } else if (categoryName == "Three") {
      return Colors.black;
    } else {
      return Colors.green;
    }
  }

  Widget itemOrder(Item item) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          // event click here
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(item.imgUrl),
                ),
              ),
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Align(
                    alignment: Alignment.centerLeft, child: Text(item.name)),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Category: ${item.category}",
                    style: TextStyle(
                      color: _categoryColor(item.category),
                    ),
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.cost.toStringAsFixed(1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  var _listCategories = [
    Category(name: 'One'),
    Category(name: 'Two'),
    Category(name: 'Three'),
    Category(name: 'Four')
  ];

  Widget _dropDown(Category category) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<Category>(
              onChanged: (Category? category) {
                if (category != null) {
                  orderController.fillByCategory(category.name);
                }
              },
              underline: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.expand_more_outlined,
                ),
              ),
              iconSize: 24,
              style: TextStyle(color: Colors.black),
              isExpanded: true,
              value: category,
              items: _listCategories.map((Category category) {
                return DropdownMenuItem<Category>(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      category.name,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  value: category,
                );
              }).toList(),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          )
        ],
      ),
    );
  }

  Row _buttonOrder() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 64,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff7CB342),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {},
              child: Text(
                "SAVE",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        Expanded(
            child: SizedBox(
          height: 64,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff7CB342),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "CHARGE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "40.46",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        )),
      ],
    );
  }
}
