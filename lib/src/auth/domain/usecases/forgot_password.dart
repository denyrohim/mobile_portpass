import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';

class ForgotPassword implements UsecaseWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String params) async =>
      _repository.forgotPassword(params);
}
