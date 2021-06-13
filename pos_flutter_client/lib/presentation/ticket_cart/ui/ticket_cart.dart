import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/bloc/ticket_cart_bloc.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/model/ticket.dart';

import 'edit_ticket_cart.dart';

class TicKetCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<TicketCartBloc, TicketCartBlocState>(
      builder: (ctx, state) {
        return _handleRenderBody(state);
      },
    ));
  }

  Widget _handleRenderBody(TicketCartBlocState state) {
    if (state is TicketState) {
      return _renderBody(state);
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Scaffold _renderBody(TicketState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4CAF50),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleKeys.btn_ticket.tr()),
            SizedBox(
              width: 10,
            ),
            _headerBuilder(state)
          ],
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
      body: _home(state),
      bottomNavigationBar:
          Padding(padding: EdgeInsets.all(15), child: _buttonOrder(state)),
    );
  }

  Stack _headerBuilder(TicketState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: state.getCountItem() < 10
              ? 25
              : (state.getCountItem() < 99 ? 35 : 45),
          height: 20,
          child: SvgPicture.asset(
            'assets/images/ic_receipt.svg',
            fit: BoxFit.fill,
            color: Colors.white,
          ),
        ),
        Text(
          state.getCountItem().toString(),
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _home(TicketState state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _dropDown(),
        ),
        SliverToBoxAdapter(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
            child: SizedBox(
              height: 0.5,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var itemTicket = state.tickets[index];
              return InkWell(
                onTap: () async {
                  BlocProvider.of<TicketCartBloc>(context).edit(itemTicket);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditTicketCart(ticket: itemTicket)));
                },
                child: _itemCart(itemTicket),
              );
            },
            childCount: state.tickets.length,
          ),
        ),
        _rowTax(state.tax),
        _rowTotal(state.getCartAmount()),
      ],
    );
  }

  final listItemDropDown = [LocaleKeys.dine_in.tr(), LocaleKeys.take_away.tr()];

  Widget _dropDown() {
    return DropdownButton<String>(
      onChanged: (value) {
        //to do onChange
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
      value: LocaleKeys.dine_in.tr(),
      iconSize: 24,
      style: TextStyle(color: Colors.black),
      isExpanded: true,
      items: listItemDropDown.map((String item) {
        return DropdownMenuItem<String>(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          value: item,
        );
      }).toList(),
    );
  }

  Widget _itemCart(Ticket ticket) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: ticket.comment != null ? 5 : 0, right: 5, left: 5, top: 5),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${ticket.item.name}  x  ",
                    ),
                    Expanded(child: Text(ticket.amount.toString())),
                    Text(
                      ticket.totalPrice().formatDouble(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Visibility(
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (ticket.comment.defaultEmpty()).toLowerCase(),
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          color: Colors.grey[800]),
                    ),
                  ),
                ),
                visible: ticket.comment.defaultEmpty() == "" ? false : true,
              )
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _rowTotal(double totalPrice) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: 35, right: 15, left: 15),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.total.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    totalPrice.formatDouble(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _rowTax(double tax) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text(LocaleKeys.tax.tr()),
                  ),
                  Text(tax.formatDouble()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buttonOrder(TicketState state) {
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
                LocaleKeys.btn_save.tr(),
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
                  LocaleKeys.btn_charge.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  state.getTotalPrice().formatDouble().toString(),
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
