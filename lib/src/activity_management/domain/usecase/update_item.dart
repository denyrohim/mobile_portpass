import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class UpdateItem implements UsecaseWithParams<Activity, UpdateItemParams> {
  const UpdateItem(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<Activity> call(UpdateItemParams params) =>
      _repository.updateItem(
        activityId: params.activityId,
        item: params.item,
      );
}

class UpdateItemParams extends Equatable {
  const UpdateItemParams({
    required this.activityId,
    required this.item,
  });

  const UpdateItemParams.empty()
      : activityId = 0,
        item = const Item.empty();

  final int activityId;
  final Item item;

  @override
  List<Object?> get props => [item, activityId];
}
