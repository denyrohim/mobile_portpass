part of 'activity_management_bloc.dart';

abstract class ActivityManagementEvent extends Equatable {
  const ActivityManagementEvent();
}

class AddActivityEvent extends ActivityManagementEvent {
  const AddActivityEvent({
    required this.activityData,
  });

  final Activity activityData;

  @override
  List<Object> get props => [activityData];
}

class DeleteActivitiesEvent extends ActivityManagementEvent {
  const DeleteActivitiesEvent({
    required this.activitiesIds,
  });

  final List<int> activitiesIds;

  @override
  List<Object> get props => [activitiesIds];
}

class GetActivitiesEvent extends ActivityManagementEvent {
  const GetActivitiesEvent();

  @override
  List<Object> get props => [];
}

class UpdateActivityEvent extends ActivityManagementEvent {
  const UpdateActivityEvent({
    required this.actions,
    required this.activity,
  });

  final List<UpdateActivityAction> actions;
  final Activity activity;

  @override
  List<Object> get props => [actions, activity];
}

class SelectAllActivityManagementEvent extends ActivityManagementEvent {
  const SelectAllActivityManagementEvent({
    required this.activities,
  });

  final List<Activity> activities;

  @override
  List<Object> get props => [activities];
}

class AddItemEvent extends ActivityManagementEvent {
  const AddItemEvent({
    required this.item,
    required this.items,
    required this.index,
  });

  final Item item;
  final List<Item> items;
  final int index;

  @override
  List<Object> get props => [item, items];
}

class DeleteItemsEvent extends ActivityManagementEvent {
  const DeleteItemsEvent({
    required this.activityId,
    required this.ids,
  });

  final int activityId;
  final List<int> ids;

  @override
  List<Object> get props => [activityId, ids];
}

class UpdateItemEvent extends ActivityManagementEvent {
  const UpdateItemEvent({
    required this.activityId,
    required this.item,
  });

  final int activityId;
  final Item item;

  @override
  List<Object> get props => [activityId, item];
}

class AddPhotoEvent extends ActivityManagementEvent {
  const AddPhotoEvent({required this.type});

  final String type;

  @override
  List<Object> get props => [type];
}

class GetActivityEvent extends ActivityManagementEvent {
  const GetActivityEvent();

  @override
  List<Object> get props => [];
}

class UpdateCheckBoxActivityEvent extends ActivityManagementEvent {
  const UpdateCheckBoxActivityEvent({
    required this.activityId,
    required this.activities,
  });

  final int activityId;
  final List<Activity> activities;

  @override
  List<Object> get props => [activityId, activities];
}
