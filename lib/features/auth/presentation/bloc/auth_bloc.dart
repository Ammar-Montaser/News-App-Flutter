import 'package:articles_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/core/usecase/usecases.dart';
import 'package:articles_app/core/common/entities/user.dart';
import 'package:articles_app/features/auth/domain/usecases/current_User.dart';
import 'package:articles_app/features/auth/domain/usecases/user_login.dart';
import 'package:articles_app/features/auth/domain/usecases/user_logout.dart';
import 'package:articles_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final UserLogout _userLogout;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _userLogout = userLogout,
        super(AuthInitial()) {
    //catch all authevent and emit loading
    // on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignup>(_handleAuthSignup);
    on<Authlogin>(_handleAuthLogin);
    on<isUserLoggedIn>(_isUserLoggedIn);
    on<logoutUser>(_logout);
  }

  void _handleAuthSignup(AuthSignup event, Emitter<AuthState> emit) async {
    final reponse = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    emit(AuthLoading());
    reponse.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _handleAuthLogin(Authlogin event, Emitter<AuthState> emit) async {
    final reponse = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    emit(AuthLoading());

    reponse.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _isUserLoggedIn(isUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => Failure(l.message), (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    emit(AuthLoading());

    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }

  void _logout(void v, Emitter<AuthState> emit) async {
    final res = await _userLogout.call(NoParams());

    _appUserCubit.updateUser(null);
    _appUserCubit.logoutUser();
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthLogout()));
  }
}
