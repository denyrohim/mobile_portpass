import 'package:dartz/dartz.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/data/datasources/activity_management_remote_data_source.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/item_model.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class ActivityManagementRepositoryImpl implements ActivityManagementRepository {
  const ActivityManagementRepositoryImpl(this._remoteDataSource);

  final ActivityManagementRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<Activity> addActivity({required Activity activity}) async {
    try {
      final result = await _remoteDataSource.addActivity(
        activity: activity as ActivityModel,
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
  }) {
    try {
      items.add(item);
      final result = items;
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<void> deleteActivities({required List<int> ids}) async {
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
      final result = await _remoteDataSource.getActivities();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Activity> updateActivity({required Activity activity}) async {
    try {
      final result = await _remoteDataSource.updateActivity(
        activity: activity as ActivityModel,
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
}