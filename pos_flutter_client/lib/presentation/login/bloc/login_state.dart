part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String email;

  LoginSuccess({required this.email});
}

class LoginError extends LoginState {
  final String errorMess;

  LoginError({required this.errorMess});
}
