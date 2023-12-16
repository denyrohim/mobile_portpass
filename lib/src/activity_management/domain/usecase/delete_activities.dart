import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class DeleteActivities implements UsecaseWithParams<dynamic, List<int>> {
  const DeleteActivities(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<dynamic> call(List<int> ids) => _repository.deleteActivities(
        ids: ids,
      );
}
