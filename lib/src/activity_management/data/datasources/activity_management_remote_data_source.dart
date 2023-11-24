import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/headers.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_progress_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ActivityManagementRemoteDataSource {
  const ActivityManagementRemoteDataSource();

  Future<ActivityModel> addActivity({
    required ActivityModel activity,
  });

  Future<void> deleteActivities({
    required List<int> ids,
  });

  Future<ActivityModel> deleteItems({
    required int activityId,
    required List<int> ids,
  });

  Future<List<ActivityModel>> getActivities();

  Future<ActivityModel> updateActivity({
    required ActivityModel activity,
  });

  Future<ActivityModel> updateItem({
    required int activityId,
    required ItemModel item,
  });
}

const kToken = 'token';

class ActivityManagementRemoteDataSourceImpl
    implements ActivityManagementRemoteDataSource {
  const ActivityManagementRemoteDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required Dio dio,
    required API api,
  })  : _dio = dio,
        _api = api,
        _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;
  final Dio _dio;
  final API _api;

  @override
  Future<ActivityModel> addActivity({
    required ActivityModel activity,
  }) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.post(
        _api.activity.activities,
        data: {
          'name': activity.name,
          'ship_name': activity.shipName,
          'type': activity.type,
          'date': activity.date,
          'time': activity.time,
          'items': activity.items.map((e) => (e as ItemModel).toMap()).toList(),
          'status': activity.status,
          'activity_progress': activity.activityProgress
              .map((e) => (e as ActivityProgressModel).toMap())
              .toList(),
          'qr_code': activity.qrCode,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
      final activityResult = result.data['data']['activity'] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return ActivityModel.fromMap(activityResult);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deleteActivities({required List<int> ids}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      await _dio.delete(
        _api.activity.activities,
        data: {
          "ids": ids,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ActivityModel> deleteItems(
      {required int activityId, required List<int> ids}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.delete(
        _api.items.items,
        data: {
          "ids": ids,
          "activity_id": activityId,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
      final activityResult = result.data['data']['activity'] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return ActivityModel.fromMap(activityResult);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ActivityModel>> getActivities() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        _api.activity.activities,
        data: {},
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
      final activityResult = result.data['data']['activity'] as List<DataMap?>?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return List<ActivityModel>.from(
        activityResult.map(
          (e) => ActivityModel.fromMap(e!),
        ),
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ActivityModel> updateActivity(
      {required ActivityModel activity}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.put(
        _api.activity.activities,
        data: {
          'name': activity.name,
          'ship_name': activity.shipName,
          'type': activity.type,
          'date': activity.date,
          'time': activity.time,
          'items': activity.items.map((e) => (e as ItemModel).toMap()).toList(),
          'status': activity.status,
          'activity_progress': activity.activityProgress
              .map((e) => (e as ActivityProgressModel).toMap())
              .toList(),
          'qr_code': activity.qrCode,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
      final activityResult = result.data['data']['activity'] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return ActivityModel.fromMap(activityResult);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ActivityModel> updateItem(
      {required int activityId, required ItemModel item}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.put(
        _api.items.items,
        data: {
          'activity_id': activityId,
          'name': item.name,
          'image': item.image,
          'weight': item.weight,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
      final activityResult = result.data['data']['activity'] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return ActivityModel.fromMap(activityResult);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
