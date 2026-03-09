part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class OnLogin extends LoginEvent {
  final String email;
  final String password;

  OnLogin(this.email, this.password);
}