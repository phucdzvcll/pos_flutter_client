import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisteringEvent) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.email, password: event.password);
        if (userCredential.user != null) {
          yield RegisterSuccess(email: event.email);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          yield RegisterError(errorMess: "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          yield RegisterError(
              errorMess: "The account already exists for that email.");
        }
      }
    }
  }
}
