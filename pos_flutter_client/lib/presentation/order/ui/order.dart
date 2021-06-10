import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/presentation/authentication/authentication.dart';
import 'package:pos_flutter_client/presentation/order/bloc/order_bloc.dart';
import 'package:pos_flutter_client/presentation/order/models/category.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/bloc/ticket_cart_bloc.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/ui/ticket_cart.dart';

import '../models/item.dart';

class Order extends StatefulWidget {
  final String email;

  const Order({Key? key, required this.email}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSearch = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4CAF50),
          title: BlocBuilder<TicketCartBloc, TicketCartBlocState>(
            builder: (ctx, state) {
              return state is TicketState
                  ? _ticketCartHeader(state, context)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
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
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (ctx, state) {
            return _body(ctx, state);
          },
        ),
      ),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.email,
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
          ListTile(
            leading: Icon(
              Icons.shopping_basket,
            ),
            title: Text('Sale'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.receipt,
            ),
            title: Text('Receipts'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list,
            ),
            title: Text('Items'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
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
            title: Text('Black office'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.redeem,
            ),
            title: Text('App'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
            ),
            title: Text('Help'),
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
            title: Text('Logout'),
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(LogoutAuthenticationEvent());
            },
          )
        ],
      ),
    );
  }

  InkWell _ticketCartHeader(TicketState ticketCartState, BuildContext ctx) {
    return InkWell(
      onTap: () {
        Navigator.push(ctx, MaterialPageRoute(builder: (_) => TicKetCart()));
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

  Widget _body(BuildContext context, OrderState state) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: BlocBuilder<TicketCartBloc, TicketCartBlocState>(
            builder: (ctx, state) {
              return state is TicketState
                  ? _buttonOrder(state)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Expanded(
          child: _buildState(state, context),
        )
      ],
    );
  }

  _buildState(OrderState orderState, BuildContext context) {
    if (orderState is LoadingOrderState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (orderState is SuccessOrderState) {
      return Column(
        children: [
          _fillStateBuilder(orderState, context),
          Expanded(
            child: ListView(
                children: orderState.items
                    .map((item) => itemOrder(item, context))
                    .toList()),
          )
        ],
      );
    } else {
      return Center(
        child: Text("Error"),
      );
    }
  }

  Widget itemOrder(Item item, BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          BlocProvider.of<TicketCartBloc>(context)
              .add(AddToCartEvent(item: item));
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

  Widget _search(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      controller: searchController,
      focusNode: focusNode,
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            color: Colors.grey,
            icon: Icon(Icons.close),
            autofocus: true,
            onPressed: isSearch
                ? () {
                    setState(() {
                      isSearch = false;
                      searchController.clear();
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<OrderBloc>(context)
                          .add(SearchEvent(value: ""));
                    });
                  }
                : null,
          )),
      onChanged: (value) {
        BlocProvider.of<OrderBloc>(context).add(SearchEvent(value: value));
      },
    );
  }

  Widget _fillStateBuilder(
      SuccessOrderState successOrderState, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
      child: Stack(
        children: [
          _fillMenuDropDown(successOrderState.categoriesState, context),
          Positioned(
            right: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: isSearch ? width : 0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: _search(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _fillMenuDropDown(
      CategoriesState categoriesState, BuildContext context) {
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
                BlocProvider.of<OrderBloc>(context).add(FillItemEvent(id: id));
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
              onPressed: !isSearch
                  ? () {
                      setState(() {
                        focusNode.requestFocus();
                        isSearch = true;
                      });
                    }
                  : null,
              icon: Icon(Icons.search),
            ),
          ),
        )
      ],
    );
  }
}

Row _buttonOrder(TicketState ticketCartState) {
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
