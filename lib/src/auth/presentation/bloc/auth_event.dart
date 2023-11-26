part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInWithCredentialEvent extends AuthEvent {
  const SignInWithCredentialEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class UpdateUserEvent extends AuthEvent {
  const UpdateUserEvent({required this.action, required this.userData});

  final UpdateUserAction action;
  final LocalUser userData;

  @override
  List<Object> get props => [action, userData];
}
