abstract class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginOkState extends LoginState {}

class LoginFailureState extends LoginState {
  final String message;

  const LoginFailureState([this.message = ""]) : super();
}
