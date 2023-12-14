import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class UpdateCheckBoxActivity
    implements UsecaseWithParams<List<Activity>, UpdateCheckBoxActivityParams> {
  const UpdateCheckBoxActivity(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<List<Activity>> call(UpdateCheckBoxActivityParams params) =>
      _repository.updateCheckBoxActivity(
        activityId: params.activityId,
        activities: params.activities,
      );
}

class UpdateCheckBoxActivityParams extends Equatable {
  const UpdateCheckBoxActivityParams({
    required this.activityId,
    required this.activities,
  });

  UpdateCheckBoxActivityParams.empty()
      : activityId = 0,
        activities = [];

  final int activityId;
  final List<Activity> activities;

  @override
  List<Object?> get props => [activityId, activities];
}
