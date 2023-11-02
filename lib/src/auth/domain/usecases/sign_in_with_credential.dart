import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignInWithCredential
    implements UsecaseWithParams<LocalUser, SignInWithCredentialParams> {
  const SignInWithCredential(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<LocalUser> call(SignInWithCredentialParams params) =>
      _repository.signInWithCredential(
        token: params.token,
      );
}

class SignInWithCredentialParams extends Equatable {
  const SignInWithCredentialParams({
    required this.token,
  });

  const SignInWithCredentialParams.empty() : token = '';

  final String token;

  @override
  List<Object?> get props => [token];
}
