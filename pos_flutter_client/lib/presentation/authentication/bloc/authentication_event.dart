part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class InitAuthenticationEvent extends AuthenticationEvent {}

class LoginAuthenticationEvent extends AuthenticationEvent {}

class LogoutAuthenticationEvent extends AuthenticationEvent {}
