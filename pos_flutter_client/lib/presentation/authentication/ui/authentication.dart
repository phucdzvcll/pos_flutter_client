import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_client/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:pos_flutter_client/presentation/order/bloc/order_bloc.dart';
import 'package:pos_flutter_client/presentation/order/ui/order.dart';
import 'package:pos_flutter_client/presentation/ticket_cart/bloc/ticket_cart_bloc.dart';

import '../../home/home_page.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (ctx, state) {
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (ctx, state) {
          Navigator.of(ctx).popUntil(ModalRoute.withName("/"));
        },
        child: _renderBody(state, ctx),
      );
    });
  }

  Widget _renderBody(AuthenticationState state, BuildContext ctx) {
    if (state is LogoutAuthenticationState) {
      return HomePage();
    } else if (state is LoggedAuthenticationState) {
      return MultiBlocProvider(providers: [
        BlocProvider<OrderBloc>(
          create: (_) {
            return OrderBloc()..add(InitEvent());
          },
        ),
        BlocProvider<TicketCartBloc>(create: (_) {
          return TicketCartBloc();
        })
      ], child: Order(email: state.email));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
