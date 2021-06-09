import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());
  var user = FirebaseAuth.instance;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is InitAuthenticationEvent) {
      if (user.currentUser != null) {
        yield LoggedAuthenticationState(email: user.currentUser!.email ?? "");
      } else {
        yield LogoutAuthenticationState();
      }
    } else if (event is LoginAuthenticationEvent) {
      yield LoggedAuthenticationState(email: user.currentUser!.email ?? "");
    } else if ((event is LogoutAuthenticationEvent)) {
      await user.signOut();
      yield LogoutAuthenticationState();
    }
  }
}
