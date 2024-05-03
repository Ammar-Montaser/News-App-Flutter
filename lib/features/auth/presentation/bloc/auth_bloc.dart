import 'package:articles_app/features/auth/domain/entities/user.dart';
import 'package:articles_app/features/auth/domain/usecases/user_login.dart';
import 'package:articles_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignup>(_handleAuthSignup);
    on<Authlogin>(_handleAuthLogin);
  }

  void _handleAuthSignup(AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final reponse = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    reponse.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthSuccess(user: r)));
  }

  void _handleAuthLogin(Authlogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final reponse = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    reponse.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthSuccess(user: r)));
  }
}
