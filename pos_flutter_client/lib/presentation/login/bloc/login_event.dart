part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoggingEvent extends LoginEvent {
  final String email, password;

  LoggingEvent({required this.email, required this.password});
}
