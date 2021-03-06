import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/common/switch_change_locale.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_controller.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/controller/ticket_cart_state.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/ui/ticket_cart.dart';

import '../controller/models/category.dart';
import '../controller/models/item.dart';
import '../controller/order_controller.dart';
import '../controller/order_state.dart';

class Order extends StatelessWidget {
  final OrderController orderController = OrderController()..getListOrders();
  final TicketCartController ticketCartController = TicketCartController();
  final String email;
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Order({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4CAF50),
          title: GetXWrapBuilder<TicketCartController>(
            initController: ticketCartController,
            builder: (_) =>
                _ticketCartHeader(ticketCartController.ticketCartStateRx.value),
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
        ),
        drawer: _drawer(context),
        body: Builder(builder: (ctx) => _body(ctx, orderController)),
      ),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.green),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            email,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          Text(
                            'POS 1',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            'p5k',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 0,
                child: SwitchWidget(),
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_basket,
            ),
            title: Text('sale'.tr),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.receipt,
            ),
            title: Text('receipts'.tr),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list,
            ),
            title: Text('items'.tr),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('setting'.tr),
            onTap: () {
              Get.back();
            },
          ),
          Divider(
            color: Colors.black45,
          ),
          ListTile(
            leading: Icon(
              Icons.insert_chart,
            ),
            title: Text('black_office'.tr),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.redeem,
            ),
            title: Text('app'.tr),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
            ),
            title: Text('help'.tr),
            onTap: () {
              Get.back();
            },
          ),
          Divider(
            color: Colors.black45,
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
            ),
            title: Text('logout'.tr),
            onTap: () {
              orderController.logout();
            },
          )
        ],
      ),
    );
  }

  InkWell _ticketCartHeader(TicketCartState ticketCartState) {
    return InkWell(
      onTap: () {
        Get.to(
          TicKetCart(
            ticketCartController: ticketCartController,
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("btn_ticket".tr),
          SizedBox(
            width: 10,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: ticketCartState.getCountItem() < 10
                    ? 25
                    : (ticketCartState.getCountItem() < 99 ? 35 : 45),
                height: 20,
                child: SvgPicture.asset(
                  'images/ic_receipt.svg',
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
              Text(
                ticketCartState.getCountItem() < 99
                    ? ticketCartState.getCountItem().toString()
                    : '99+',
                style: TextStyle(fontSize: 15),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context, OrderController orderController) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GetXWrapBuilder<OrderController>(
            builder: (_) => Padding(
                  padding: EdgeInsets.all(15),
                  child: _buttonOrder(
                      ticketCartController.ticketCartStateRx.value),
                ),
            initController: orderController),
        GetXWrapBuilder<OrderController>(
            initController: orderController,
            builder: (_) =>
                _fillBar(orderController.categoryRx.value, context)),
        Expanded(
          child: GetXWrapBuilder<OrderController>(
            initController: orderController,
            builder: (_) => _buildState(orderController.orderStateRx.value),
          ),
        )
      ],
    );
  }

  _buildState(OrderItemsState orderState) {
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

  Widget itemOrder(Item item) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          ticketCartController.addToTicketCart(item);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 54,
                height: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    border: Border.all(color: Colors.grey, width: 0.25),
                    image: DecorationImage(
                      image: NetworkImage(item.imgUrl),
                    ),
                  ),
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
                    item.price.formatDouble(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _search(bool isVisible) {
    return TextField(
      focusNode: _focusNode,
      textAlignVertical: TextAlignVertical.center,
      controller: _searchController,
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: "search".tr,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            color: Colors.grey,
            icon: Icon(Icons.close),
            onPressed: () {
              _focusNode.unfocus();
              orderController.changeFillBarState();
              _searchController.clear();
            },
          )),
      onChanged: (value) {
        orderController.fillBySearch(value);
      },
    );
  }

  Widget _fillBar(CategoriesState categoriesState, BuildContext context) {
    return GetXWrapBuilder<OrderController>(
      builder: (_) => _fillStateBuilder(
          orderController.fillBarRX.value, categoriesState, context),
      initController: orderController,
    );
  }

  Widget _fillStateBuilder(FillBarState fillBarState,
      CategoriesState categoriesState, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
      child: Stack(
        children: [
          _fillMenuDropDown(
              categoriesState, fillBarState is FillState ? true : false),
          Positioned(
            right: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: fillBarState is FillState ? 0 : width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: _search(fillBarState is SearchState),
            ),
          )
        ],
      ),
    );
  }

  Widget _fillMenuDropDown(CategoriesState categoriesState, bool isVisible) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 20,
          child: DropdownButton<int>(
            onChanged: (int? id) {
              if (id != null) {
                orderController.fillByCategory(id);
              }
            },
            underline: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0x00000000),
              ),
            ),
            icon: Icon(
              Icons.expand_more_outlined,
            ),
            style: TextStyle(color: Colors.black),
            isExpanded: true,
            value: categoriesState.selectedCategoryId,
            items: categoriesState.categories.map((Category category) {
              return DropdownMenuItem<int>(
                child: Text(
                  category.name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                value: category.id,
              );
            }).toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: IconButton(
              onPressed: () {
                orderController.changeFillBarState();
                _focusNode.requestFocus();
              },
              icon: Icon(Icons.search),
            ),
          ),
        )
      ],
    );
  }

  Row _buttonOrder(TicketCartState ticketCartState) {
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
                "btn_save".tr,
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
                    "btn_charge".tr,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    ticketCartState.getCartAmount().formatDouble(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//
// extension HexColor on Color {
//   /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
//   static Color fromHex(String hexString) {
//     final buffer = StringBuffer();
//     if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//     buffer.write(hexString.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }
//
//   /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
//   String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
//       '${alpha.toRadixString(16).padLeft(2, '0')}'
//       '${red.toRadixString(16).padLeft(2, '0')}'
//       '${green.toRadixString(16).padLeft(2, '0')}'
//       '${blue.toRadixString(16).padLeft(2, '0')}';
// }
