part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckIfUserIsLoggedInEvent extends AuthEvent {
  const CheckIfUserIsLoggedInEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({required this.action, required this.userData})
      : assert(
          userData is String || userData is File,
          'userData must be a String or a File, but was ${userData.runtimeType}',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object> get props => [action, userData];
}
