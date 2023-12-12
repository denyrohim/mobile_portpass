import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class AddPhotoItem implements UsecaseWithParams<dynamic, String> {
  const AddPhotoItem(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture call(String type) => _repository.addPhotoItem(
      type: type
  );
}
