import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';

class AddPhoto implements UsecaseWithParams<dynamic, String> {
  const AddPhoto(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<dynamic> call(String type) => _repository.addPhoto(
        type: type,
      );
}
