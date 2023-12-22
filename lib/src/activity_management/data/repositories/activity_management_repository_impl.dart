import 'package:dartz/dartz.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/data/datasources/activity_management_remote_data_source.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/item_model.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_route.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/ship.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class ActivityManagementRepositoryImpl implements ActivityManagementRepository {
  const ActivityManagementRepositoryImpl(this._remoteDataSource);

  final ActivityManagementRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<Activity> addActivity({
    required Activity activity,
  }) async {
    try {
      final ships = await _remoteDataSource.getShips();
      final activityRoutes = await _remoteDataSource.getRoutes();

      final itemsData = List<ItemModel>.from(activity.items
          .map((item) => ItemModel(
                id: item.id,
                imagePath: item.imagePath,
                image: item.image,
                name: item.name,
                amount: item.amount,
                unit: item.unit,
              ))
          .toList());

      final activityData = ActivityModel(
        id: activity.id,
        name: activity.name,
        shipName: activity.shipName,
        type: activity.type,
        date: activity.date,
        time: activity.time,
        items: itemsData,
        status: activity.status,
        activityProgress: activity.activityProgress,
        qrCode: activity.qrCode,
        isChecked: activity.isChecked,
        route: activity.route,
      );
      final result = await _remoteDataSource.addActivity(
        activity: activityData,
        ships: ships,
        activityRoutes: activityRoutes,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Item>> addItem({
    required List<Item> items,
    required Item item,
    required int index,
  }) {
    try {
      if (index != -1) {
        items[index] = item;
      } else {
        items.add(item);
      }
      final result = items;
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<dynamic> deleteActivities({required List<int> ids}) async {
    try {
      final result = await _remoteDataSource.deleteActivities(
        ids: ids,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Activity> deleteItems(
      {required int activityId, required List<int> ids}) async {
    try {
      final result = await _remoteDataSource.deleteItems(
        activityId: activityId,
        ids: ids,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Activity>> getActivities() async {
    try {
      final ships = await _remoteDataSource.getShips();
      final result = await _remoteDataSource.getActivities(
        ships: ships,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Activity> updateActivity({
    required Activity activity,
    required List<int> deletedIds,
  }) async {
    try {
      final itemsData = List<ItemModel>.from(activity.items
          .map((item) => ItemModel(
                id: item.id,
                imagePath: item.imagePath,
                image: item.image,
                name: item.name,
                amount: item.amount,
                unit: item.unit,
              ))
          .toList());

      final activityData = ActivityModel(
        id: activity.id,
        name: activity.name,
        shipName: activity.shipName,
        type: activity.type,
        date: activity.date,
        time: activity.time,
        items: itemsData,
        status: activity.status,
        activityProgress: const [],
        qrCode: activity.qrCode,
        isChecked: activity.isChecked,
        route: activity.route,
      );
      final ships = await _remoteDataSource.getShips();
      final activityRoutes = await _remoteDataSource.getRoutes();
      final result = await _remoteDataSource.updateActivity(
        activity: activityData,
        ships: ships,
        activityRoutes: activityRoutes,
        deletedIds: deletedIds,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Activity> updateItem(
      {required int activityId, required Item item}) async {
    try {
      final result = await _remoteDataSource.updateItem(
        activityId: activityId,
        item: item as ItemModel,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture addPhotoItem({required String type}) async {
    try {
      final result = await _remoteDataSource.addPhotoItem(type: type);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Activity>> changeStatusActivities({
    required List<Activity> activities,
    required String status,
  }) {
    try {
      List<Activity> activitiesResult = [];
      if (status == "Aktivitas") {
        for (var i = 0; i < activities.length; i++) {
          if (activities[i].status != "Cancelled" &&
              activities[i].status != "Rejected") {
            activitiesResult.add(activities[i]);
          }
        }
      } else if (status == "Finished") {
        for (var i = 0; i < activities.length; i++) {
          if (activities[i].status == "Finished") {
            activitiesResult.add(activities[i]);
          }
        }
      } else if (status == "Pending") {
        for (var i = 0; i < activities.length; i++) {
          if (activities[i].status == "Pending") {
            activitiesResult.add(activities[i]);
          }
        }
      } else if (status == "On Progress") {
        for (var i = 0; i < activities.length; i++) {
          if (activities[i].status == "On Progress") {
            activitiesResult.add(activities[i]);
          }
        }
      } else if (status == "Draft") {
        for (var i = 0; i < activities.length; i++) {
          if (activities[i].status == "Cancelled" ||
              activities[i].status == "Rejected") {
            activitiesResult.add(activities[i]);
          }
        }
      }

      return Future.value(Right(activitiesResult));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<List<Activity>> cancelCheckBoxActivities(
      {required List<Activity> activities}) {
    try {
      final List<Activity> result = [];
      for (int i = 0; i < activities.length; i++) {
        final ActivityModel activity = activities[i] as ActivityModel;
        final newActivity = activity.copyWith(isChecked: false);
        result.add(newActivity);
      }
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<List<Activity>> updateCheckBoxActivity(
      {required int activityId, required List<Activity> activities}) {
    try {
      final ActivityModel activity = activities[activityId] as ActivityModel;
      final newActivity = activity.copyWith(isChecked: !activity.isChecked);
      final List<Activity> result = [];
      for (int i = 0; i < activities.length; i++) {
        if (i == activityId) {
          result.add(newActivity);
        } else {
          result.add(activities[i]);
        }
      }
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<List<Activity>> selectAllActivities(
      {required List<Activity> activities}) {
    try {
      final List<Activity> result = [];
      for (int i = 0; i < activities.length; i++) {
        final ActivityModel activity = activities[i] as ActivityModel;
        final newActivity = activity.copyWith(isChecked: true);
        result.add(newActivity);
      }
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<List<Ship>> getShip() async {
    try {
      final result = await _remoteDataSource.getShips();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ActivityRoute>> getActivityRoutes() async {
    try {
      final result = await _remoteDataSource.getRoutes();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
