import 'package:bloc/bloc.dart';
import 'package:port_pass_app/core/enums/update_user_action.dart';

import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in.dart';
import 'package:equatable/equatable.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in_with_credential.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_out.dart';
import 'package:port_pass_app/src/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignInWithCredential signInWithCredential,
    required UpdateUser updateUser,
    required SignOut signOut,
  })  : _signIn = signIn,
        _signInWithCredential = signInWithCredential,
        _updateUser = updateUser,
        _signOut = signOut,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInWithCredentialEvent>(_signInWithCredentialHandler);
    on<SignInEvent>(_signInHandler);
    on<UpdateUserEvent>(_updateUserHandler);
    on<SignOutEvent>(signOutHandler);
  }
  final SignIn _signIn;
  final SignInWithCredential _signInWithCredential;
  final UpdateUser _updateUser;
  final SignOut _signOut;

  Future<void> _signInWithCredentialHandler(
    SignInWithCredentialEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInWithCredential();
    result.fold(
      (_) => emit(const NotSignedIn()),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(SignInParams(
      email: event.email,
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
      (user) => emit(UserUpdated(user)),
    );
  }

  Future<void> signOutHandler(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signOut();
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const NotSignedIn()),
    );
  }
}
