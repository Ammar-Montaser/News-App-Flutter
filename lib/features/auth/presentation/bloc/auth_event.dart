part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignup extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignup(this.name, this.email, this.password);
}

final class Authlogin extends AuthEvent {}
