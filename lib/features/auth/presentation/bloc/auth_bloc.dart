import 'package:articles_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignup>(_handleAuthSignup);
  }

  void _handleAuthSignup(event, emit) async {
    final reponse = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    reponse.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthSuccess(uid: r)));
  }
}