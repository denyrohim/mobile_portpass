import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class GetActivities implements UsecaseWithoutParams<List<Activity>> {
  const GetActivities(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<List<Activity>> call() => _repository.getActivities();
}
