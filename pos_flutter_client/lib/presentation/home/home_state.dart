abstract class AuthenticationState {}

class LoginState extends AuthenticationState {
  final String email;

  LoginState({required this.email});
}

class LogoutState extends AuthenticationState {}

class LoadingState extends AuthenticationState {}
