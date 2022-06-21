part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

//First time user opens app they are unauthenticated
// on the event AppStarted
class Unauthenticated extends AuthState {}

// Anonymous state as user can always be logged in
// Brilliant move marcus ng
// When app is started we start with Unauthenticated and post logging in the user
// anonymously we yield Anonymous
class Anonymous extends AuthState {
  final User user;

  const Anonymous(this.user);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [user];
}

//Authenticated state
// On Login
class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [user];
}
