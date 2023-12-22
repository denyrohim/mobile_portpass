import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class UpdateActivity
    implements UsecaseWithParams<Activity, UpdateActivityParams> {
  const UpdateActivity(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<Activity> call(UpdateActivityParams params) =>
      _repository.updateActivity(
        activity: params.activity,
        deletedIds: params.deletedIds,
      );
}

class UpdateActivityParams extends Equatable {
  const UpdateActivityParams({
    required this.activity,
    required this.deletedIds,
  });

  UpdateActivityParams.empty()
      : activity = Activity.empty(),
        deletedIds = [];

  final Activity activity;
  final List<int> deletedIds;

  @override
  List<Object?> get props => [activity, deletedIds];
}
