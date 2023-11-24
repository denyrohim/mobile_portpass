import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'activity_management_event.dart';
part 'activity_management_state.dart';

class ActivityManagementBloc
    extends Bloc<ActivityManagementEvent, ActivityManagementState> {
  ActivityManagementBloc() : super(ActivityManagementInitial()) {
    on<ActivityManagementEvent>((event, emit) {});
  }
}
