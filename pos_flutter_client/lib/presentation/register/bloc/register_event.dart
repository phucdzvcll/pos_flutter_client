part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisteringEvent extends RegisterEvent {
  final String email, password;

  RegisteringEvent({required this.email, required this.password});
}
