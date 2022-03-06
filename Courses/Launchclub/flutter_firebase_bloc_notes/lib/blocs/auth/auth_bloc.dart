import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_bloc_notes/repositories/auth/auth_repository.dart';

import '../../models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(Unauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  _onAppStarted(event, emit) async* {
    try {
      User? currentUser = await _authRepository.getCurrentUser();
      currentUser ??= await _authRepository.loginAnonymously();
      final isAnonymous = await _authRepository.isAnonymous();
      if (isAnonymous) {
        yield Anonymous(currentUser);
      } else {
        yield Authenticated(currentUser);
      }
    } catch (err) {
      log(err.toString());
      yield Unauthenticated();
    }
  }

  _onLogin(event, emit) async* {
    try {
      User? currentUser = await _authRepository.getCurrentUser();
      yield Authenticated(currentUser!);
    } catch (err) {
      log(err.toString());
      yield Unauthenticated();
    }
  }

  _onLogout(event, emit) async* {
    try {
      User? currentUser = await _authRepository.logOut();
      yield AppStarted();
    } catch (err) {
      log(err.toString());
      yield Unauthenticated();
    }
  }
}
