part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String email;

  RegisterSuccess({required this.email});
}

class RegisterError extends RegisterState {
  final String errorMess;

  RegisterError({required this.errorMess});
}
