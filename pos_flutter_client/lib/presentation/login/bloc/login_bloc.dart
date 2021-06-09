import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoggingEvent) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password);
        if (userCredential.user != null) {
          yield LoginSuccess(email: event.email);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          yield LoginError(errorMess: "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          yield LoginError(errorMess: "Wrong password provided for that user.");
        }
      }
    }
  }
}
