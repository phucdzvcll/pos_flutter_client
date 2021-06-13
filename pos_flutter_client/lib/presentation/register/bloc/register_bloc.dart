import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';

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
          yield RegisterError(errorMess: LocaleKeys.password_weak.tr());
        } else if (e.code == 'email-already-in-use') {
          yield RegisterError(errorMess: LocaleKeys.email_already_in_use.tr());
        }
      }
    }
  }
}
