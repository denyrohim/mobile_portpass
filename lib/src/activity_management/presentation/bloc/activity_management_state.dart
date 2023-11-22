part of 'activity_management_bloc.dart';

sealed class ActivityManagementState extends Equatable {
  const ActivityManagementState();
  
  @override
  List<Object> get props => [];
}

final class ActivityManagementInitial extends ActivityManagementState {}
