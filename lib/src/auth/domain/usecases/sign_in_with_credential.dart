import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';

class SignInWithCredential implements UsecaseWithoutParams<LocalUser> {
  const SignInWithCredential(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<LocalUser> call() => _repository.signInWithCredential();
}
