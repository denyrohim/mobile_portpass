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

// class UpdateUserEvent extends AuthEvent {
//   UpdateUserEvent({required this.action, required this.userData})
//       : assert(
//           userData is String || userData is File,
//           'userData must be a String or a File, but was ${userData.runtimeType}',
//         );

//   final UpdateUserAction action;
//   final dynamic userData;

//   @override
//   List<Object> get props => [action, userData];
// }
