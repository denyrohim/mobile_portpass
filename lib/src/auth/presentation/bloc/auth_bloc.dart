import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:port_pass_app/core/enums/update_user_action.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in.dart';
import 'package:port_pass_app/src/auth/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _updateUser = updateUser,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<CheckIfUserIsLoggedInEvent>(_checkIfUserIsLoggedInHandler);
    on<SignInEvent>(_signInHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }
  final SignIn _signIn;
  final UpdateUser _updateUser;

  Future<void> _checkIfUserIsLoggedInHandler(
    CheckIfUserIsLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        emit(const AuthInitial());
      },
    );
    // result.fold(
    //   (failure) => emit(AuthError(failure.errorMessage)),
    //   (user) => emit(SignedIn(user)),
    // );
    // emit(SignedIn(result));
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(SignInParams(
      username: event.username,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUser(UpdateUserParams(
      action: event.action,
      userData: event.userData,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const UserUpdated()),
    );
  }
}
