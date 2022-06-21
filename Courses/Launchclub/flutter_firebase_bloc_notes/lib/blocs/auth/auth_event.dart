part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

//Three events
// 1. App started
class AppStarted extends AuthEvent {}

//2. Login
class Login extends AuthEvent {}

//3. Logout
class Logout extends AuthEvent {}
