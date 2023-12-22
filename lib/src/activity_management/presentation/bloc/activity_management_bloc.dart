import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/enums/update_activity_action.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_route.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/ship.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/add_activity.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/add_item.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/add_photo_item.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/cancel_check_box_activities.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/change_status_activities.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/delete_activities.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/delete_items.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/get_activities.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/get_ships.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/select_all_activities.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/update_activity.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/update_check_box_activity.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/update_item.dart';

import '../../domain/usecase/get_activity_routes.dart';

part 'activity_management_event.dart';
part 'activity_management_state.dart';

class ActivityManagementBloc
    extends Bloc<ActivityManagementEvent, ActivityManagementState> {
  ActivityManagementBloc(
      {required AddActivity addActivity,
      required AddItem addItem,
      required DeleteActivities deleteActivities,
      required DeleteItems deleteItems,
      required GetActivities getActivities,
      required UpdateActivity updateActivity,
      required UpdateItem updateItem,
      required AddPhotoItem addPhotoItem,
      required ChangeStatusActivities changeStatusActivities,
      required CancelCheckBoxActivities cancelCheckBoxActivities,
      required UpdateCheckBoxActivity updateCheckBoxActivity,
      required SelectAllActivities selectAllActivities,
      required GetShips getShips,
      required GetActivityRoutes getActivityRoutes})
      : _addActivity = addActivity,
        _addItem = addItem,
        _deleteActivities = deleteActivities,
        _deleteItems = deleteItems,
        _getActivities = getActivities,
        _updateActivity = updateActivity,
        _updateItem = updateItem,
        _addPhoto = addPhotoItem,
        _changeStatusActivities = changeStatusActivities,
        _cancelCheckBoxActivities = cancelCheckBoxActivities,
        _updateCheckBoxActivity = updateCheckBoxActivity,
        _selectAllActivities = selectAllActivities,
        _getShips = getShips,
        _getActivityRoutes = getActivityRoutes,
        super(const ActivityManagementInitial()) {
    on<ActivityManagementEvent>((event, emit) {
      emit(const ActivityManagementLoading());
    });
    on<AddActivityEvent>(_addActivityHandler);
    on<AddItemEvent>(_addItemHandler);
    on<DeleteActivitiesEvent>(_deleteActivitiesHandler);
    on<DeleteItemsEvent>(_deleteItemsHandler);
    on<GetActivitiesEvent>(_getActivitiesHandler);
    on<UpdateActivityEvent>(_updateActivityHandler);
    on<UpdateItemEvent>(_updateItemHandler);
    on<AddPhotoEvent>(_addPhotoHandler);
    on<ChangeStatusActivitiesEvent>(_changeStatusActivitiesHandler);
    on<CancelCheckBoxActivitiesEvent>(_cancelCheckBoxActivityHandler);
    on<UpdateCheckBoxActivityEvent>(_updateCheckBoxActivityHandler);
    on<SelectAllActivitiesEvent>(_selectAllActivitiesHandler);
    on<GetShipsEvent>(_getShipsHandler);
    on<GetActivityRoutesEvent>(_getActivityRoutesHandler);
  }
  final AddActivity _addActivity;
  final AddItem _addItem;
  final DeleteActivities _deleteActivities;
  final DeleteItems _deleteItems;
  final GetActivities _getActivities;
  final UpdateActivity _updateActivity;
  final UpdateItem _updateItem;
  final AddPhotoItem _addPhoto;
  final ChangeStatusActivities _changeStatusActivities;
  final CancelCheckBoxActivities _cancelCheckBoxActivities;
  final UpdateCheckBoxActivity _updateCheckBoxActivity;
  final SelectAllActivities _selectAllActivities;
  final GetShips _getShips;
  final GetActivityRoutes _getActivityRoutes;

  Future<void> _addActivityHandler(
    AddActivityEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _addActivity(
      event.activityData,
    );
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (activity) => emit(DataAdded(activity)),
    );
  }

  Future<void> _addItemHandler(
    AddItemEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _addItem(
      AddItemParams(
        items: event.items,
        item: event.item,
        index: event.index,
      ),
    );
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (items) => emit(ItemAdded(items)),
    );
  }

  Future<void> _deleteActivitiesHandler(
    DeleteActivitiesEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _deleteActivities(
      event.activitiesIds,
    );
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (_) => emit(const DataDeleted()),
    );
  }

  Future<void> _deleteItemsHandler(
    DeleteItemsEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _deleteItems(
      DeleteItemsParams(activityId: event.activityId, ids: event.ids),
    );
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (_) => emit(const DataDeleted()),
    );
  }

  Future<void> _getActivitiesHandler(
    GetActivitiesEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _getActivities();
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (activities) => emit(DataLoaded(activities)),
    );
  }

  Future<void> _getShipsHandler(
    GetShipsEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _getShips();
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (ships) => emit(ShipsLoaded(ships)),
    );
  }

  Future<void> _getActivityRoutesHandler(
    GetActivityRoutesEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _getActivityRoutes();
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (activityRoutes) => emit(ActivityRoutesLoaded(activityRoutes)),
    );
  }

  Future<void> _updateActivityHandler(
    UpdateActivityEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _updateActivity(
      event.activity,
    );
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (activity) => emit(DataUpdated(activity)),
    );
  }

  Future<void> _updateItemHandler(
    UpdateItemEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _updateItem(
      UpdateItemParams(activityId: event.activityId, item: event.item),
    );
    result.fold(
      (failure) => emit(ActivityManagementError(failure.errorMessage)),
      (item) => emit(DataUpdated(item)),
    );
  }

  Future<void> _addPhotoHandler(
    AddPhotoEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _addPhoto(event.type);
    return result.fold(
        (failure) => emit(ActivityManagementError(failure.errorMessage)),
        (photo) => emit(PhotoAdded(photo)));
  }

  Future<void> _changeStatusActivitiesHandler(
    ChangeStatusActivitiesEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _changeStatusActivities(ChangeStatusActivitiesParams(
        activities: event.activities, status: event.status));
    return result.fold(
        (failure) => emit(ActivityManagementError(failure.errorMessage)),
        (activities) => emit(StatusChanged(activities)));
  }

  Future<List<Activity>> _cancelCheckBoxActivityHandler(
    CancelCheckBoxActivitiesEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _cancelCheckBoxActivities(
      event.activities,
    );
    return result.fold(
      (failure) {
        emit(ActivityManagementError(failure.errorMessage));
        return event.activities;
      },
      (activities) {
        emit(UnshowChecked(activities));
        return activities;
      },
    );
  }

  Future<List<Activity>> _updateCheckBoxActivityHandler(
    UpdateCheckBoxActivityEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _updateCheckBoxActivity(UpdateCheckBoxActivityParams(
      activityId: event.activityId,
      activities: event.activities,
    ));
    return result.fold(
      (failure) {
        emit(ActivityManagementError(failure.errorMessage));
        return event.activities;
      },
      (activities) {
        emit(UpdateChecked(activities));
        return activities;
      },
    );
  }

  Future<List<Activity>> _selectAllActivitiesHandler(
    SelectAllActivitiesEvent event,
    Emitter<ActivityManagementState> emit,
  ) async {
    final result = await _selectAllActivities(
      event.activities,
    );
    return result.fold(
      (failure) {
        emit(ActivityManagementError(failure.errorMessage));
        return event.activities;
      },
      (activities) {
        emit(SelectedAll(activities));
        return activities;
      },
    );
  }
}
