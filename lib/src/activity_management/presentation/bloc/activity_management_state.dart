part of 'activity_management_bloc.dart';

abstract class ActivityManagementState extends Equatable {
  const ActivityManagementState();

  @override
  List<Object> get props => [];
}

class ActivityManagementInitial extends ActivityManagementState {
  const ActivityManagementInitial();
}

class ActivityManagementLoading extends ActivityManagementState {
  const ActivityManagementLoading();
}

class ActivityManagementError extends ActivityManagementState {
  const ActivityManagementError(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];
}

class ActivityManagementUpdating extends ActivityManagementState {
  const ActivityManagementUpdating();
}

class UpdateChecked extends ActivityManagementState {
  const UpdateChecked(this.activities);

  final List<Activity> activities;

  @override
  List<Object> get props => [activities];
}

class DataLoaded extends ActivityManagementState {
  const DataLoaded(this.activities);

  final List<Activity> activities;

  @override
  List<Object> get props => [activities];
}

class SelectedAll extends ActivityManagementState {
  const SelectedAll(this.activities);

  final List<Activity> activities;

  @override
  List<Object> get props => [activities];
}

class DataAdded extends ActivityManagementState {
  const DataAdded();
}

class DataDeleted extends ActivityManagementState {
  const DataDeleted();
}

class DataUpdated extends ActivityManagementState {
  const DataUpdated(this.activity);

  final Activity activity;

  @override
  List<Object> get props => [activity];
}
