import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class ChangeStatusActivities
    implements UsecaseWithParams<List<Activity>, ChangeStatusActivitiesParams> {
  const ChangeStatusActivities(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<List<Activity>> call(ChangeStatusActivitiesParams params) =>
      _repository.changeStatusActivities(
        activities: params.activities,
        status: params.status,
      );
}

class ChangeStatusActivitiesParams extends Equatable {
  const ChangeStatusActivitiesParams({
    required this.activities,
    required this.status,
  });

  ChangeStatusActivitiesParams.empty()
      : activities = [],
        status = "";

  final List<Activity> activities;
  final String status;

  @override
  List<Object?> get props => [activities, status];
}
