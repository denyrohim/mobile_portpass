import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class SelectAllActivities
    implements UsecaseWithParams<List<Activity>, List<Activity>> {
  const SelectAllActivities(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<List<Activity>> call(List<Activity> activities) =>
      _repository.selectAllActivities(
        activities: activities,
      );
}
