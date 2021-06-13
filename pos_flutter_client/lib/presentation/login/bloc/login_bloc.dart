import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';

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
          yield LoginError(errorMess: LocaleKeys.user_not_found.tr());
        } else if (e.code == 'wrong-password') {
          yield LoginError(errorMess: LocaleKeys.wrong_password.tr());
        }
      }
    }
  }
}
