import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:port_pass_app/core/errors/failure.dart';

import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
  })  : _signIn = signIn,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInWithCredentialEvent>(_signInWithCredentialHandler);
    on<SignInEvent>(_signInHandler);
  }
  final SignIn _signIn;

  Future<void> _signInWithCredentialHandler(
    SignInWithCredentialEvent event,
    Emitter<AuthState> emit,
  ) async {
    const result = Left(
      ServerFailure(message: 'Never SignIn', statusCode: HttpStatus.badRequest),
    );
    result.fold(
      (_) => emit(const NotSignedIn()),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    // final result = await _signIn(SignInParams(
    //   username: event.username,
    //   password: event.password,
    // ));

    const result = Right(
      LocalUserModel.empty(),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  // Future<void> _updateUserHandler(
  //   UpdateUserEvent event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   final result = await _updateUser(UpdateUserParams(
  //     action: event.action,
  //     userData: event.userData,
  //   ));
  //   result.fold(
  //     (failure) => emit(AuthError(failure.errorMessage)),
  //     (_) => emit(const UserUpdated()),
  //   );
  // }
}
