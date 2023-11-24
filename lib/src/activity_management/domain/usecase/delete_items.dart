import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class DeleteItems implements UsecaseWithParams<Activity, DeleteItemsParams> {
  const DeleteItems(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<Activity> call(DeleteItemsParams params) =>
      _repository.deleteItems(
        activityId: params.activityId,
        ids: params.ids,
      );
}

class DeleteItemsParams extends Equatable {
  const DeleteItemsParams({
    required this.activityId,
    required this.ids,
  });

  DeleteItemsParams.empty()
      : activityId = 0,
        ids = [];

  final int activityId;
  final List<int> ids;

  @override
  List<Object?> get props => [activityId, ids];
}
