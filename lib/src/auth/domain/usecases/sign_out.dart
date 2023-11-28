import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';

class SignOut implements UsecaseWithoutParams<void> {
  const SignOut(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call() => _repository.signOut();
}
