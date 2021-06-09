part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class LoggedAuthenticationState extends AuthenticationState {
  final String email;

  LoggedAuthenticationState({required this.email});
}

class LogoutAuthenticationState extends AuthenticationState {}
