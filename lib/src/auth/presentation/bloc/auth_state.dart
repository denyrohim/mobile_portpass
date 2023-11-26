part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];
}

class SignedIn extends AuthState {
  const SignedIn(
    this.user,
  );

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

class NotSignedIn extends AuthState {
  const NotSignedIn();

  @override
  List<Object> get props => [];
}

class UserUpdated extends AuthState {
  const UserUpdated(
    this.user,
  );

  final LocalUser user;

  @override
  List<Object> get props => [user];
}