import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/core/utils/headers.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_route_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/item_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/ship_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ActivityManagementRemoteDataSource {
  const ActivityManagementRemoteDataSource();

  Future<ActivityModel> addActivity({
    required ActivityModel activity,
    required List<ShipModel> ships,
    required List<ActivityRouteModel> activityRoutes,
  });

  Future<dynamic> deleteActivities({
    required List<int> ids,
  });

  Future<ActivityModel> deleteItems({
    required int activityId,
    required List<int> ids,
  });

  Future<List<ActivityModel>> getActivities({
    required List<ShipModel> ships,
  });
  Future<ActivityModel> getActivity({
    required int id,
    required List<ShipModel> ships,
  });

  Future<List<ItemModel>> getItems();

  Future<ActivityModel> updateActivity({
    required ActivityModel activity,
    required List<ShipModel> ships,
    required List<ActivityRouteModel> activityRoutes,
  });

  Future<ActivityModel> updateItem({
    required int activityId,
    required ItemModel item,
  });

  Future<dynamic> addPhotoItem({required String type});

  Future<List<ShipModel>> getShips();
  Future<List<ActivityRouteModel>> getRoutes();
}

const kToken = 'token';

class ActivityManagementRemoteDataSourceImpl
    implements ActivityManagementRemoteDataSource {
  const ActivityManagementRemoteDataSourceImpl(
      {required SharedPreferences sharedPreferences,
      required Dio dio,
      required API api,
      required ImagePicker imagePicker})
      : _dio = dio,
        _api = api,
        _sharedPreferences = sharedPreferences,
        _imagePicker = imagePicker;

  final SharedPreferences _sharedPreferences;
  final Dio _dio;
  final API _api;
  final ImagePicker _imagePicker;

  @override
  Future<ActivityModel> addActivity({
    required ActivityModel activity,
    required List<ShipModel> ships,
    required List<ActivityRouteModel> activityRoutes,
  }) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      int shipId =
          ships.firstWhere((element) => element.name == activity.shipName).id;
      int activityRouteId = activityRoutes
          .firstWhere((element) => element.name == activity.route)
          .id;

      debugPrint("shipId: $shipId");
      debugPrint("activityRouteId: $activityRouteId");

      final result = await _dio.post(
        _api.activity.activities,
        data: {
          'title': activity.name,
          'ship_id': shipId,
          'jenis_pekerjaan': activity.type,
          'start_date': DateFormat('yyyy-MM-dd HH:mm')
              .format(DateTime.parse('${activity.date} ${activity.time}')),
          'activity_route_id': activityRouteId,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      final activityResult = result.data['data'] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      int activityId = activityResult['id'] as int;

      for (var i = 0; i < activity.items.length; i++) {
        final imageUri = CoreUtils.fileToUriBase64(activity.items[i].image);
        final resultItems = await _dio.post(
          _api.items.items,
          data: {
            'activity_id': activityId,
            'name': activity.items[i].name,
            'amount': activity.items[i].amount,
            'unit': activity.items[i].unit,
            'image': imageUri,
          },
          options: Options(
            headers: ApiHeaders.getHeaders(
              token: token,
            ).headers,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );

        if (resultItems.statusCode != 200) {
          throw const ServerException(
              message: "Failed to add item", statusCode: 400);
        }
      }
      return activity;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<dynamic> deleteActivities({required List<int> ids}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.post(
        "${_api.activity.activityDetail}/delete-list",
        data: {
          "ids": ids,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (result.statusCode != 200) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
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
          validateStatus: (status) {
            return status! < 500;
          },
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
  Future<List<ActivityModel>> getActivities({
    required List<ShipModel> ships,
  }) async {
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
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final activityResult = result.data['data'] as List<dynamic>?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      final activities = activityResult.map((e) {
        final activity = e as DataMap;

        final shipId = activity['ship_id'] as int;
        final shipName =
            ships.firstWhere((element) => element.id == shipId).name;

        final qrCode = activity['qr_code'] as String;
        final imageQrCode = CoreUtils.uriBase64ToFile(
            qrCode, "qr-code-activity-${activity['id']}",
            extension: 'png');
        activity['qr_code'] = imageQrCode;

        final activityRoute = activity['activity_route'];
        activity['route'] =
            activityRoute != null ? activity['activity_route']!['name'] : "";
        debugPrint("route: ${activity['route']}");

        activity['is_checked'] = false;

        activity['goods'].map((e) {
          if (e['image'] != null) {
            final imagePath = e['image'];
            e['image'] = "${_api.baseUrl}/images/barang/$imagePath";
          } else {
            e['image'] = '';
          }
        }).toList();

        if ((activity['activity_progress'] as List<dynamic>).isNotEmpty) {
          activity['activity_progress'].map((e) {
            if (e['image'] != null) {
              final imagePath = e['image'];
              e['image'] = "${_api.baseUrl}/images/barang/$imagePath";
            } else {
              e['image'] = '';
            }
          }).toList();
        } else {
          activity['activity_progress'] = [];
        }

        return {
          ...activity,
          'ship_id': shipName,
          'router': activity['activity_route_id'] as int,
        };
      }).toList();

      if (activities.isEmpty) {
        throw const ServerException(
            message: "There is no activity", statusCode: 400);
      }
      return activities.map((e) => ActivityModel.fromMap(e)).toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ActivityModel> getActivity({
    required int id,
    required List<ShipModel> ships,
  }) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        "${_api.activity.activityDetail}/$id",
        data: {},
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final activityResult = result.data['data'][0] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      final shipId = activityResult['ship_id'] as int;
      final shipName = ships.firstWhere((element) => element.id == shipId).name;
      activityResult['ship_id'] = shipName;

      final qrCode = activityResult['qr_code'] as String;
      final imageQrCode = CoreUtils.uriBase64ToFile(
          qrCode, "qr-code-activity-${activityResult['id']}",
          extension: 'png');
      activityResult['qr_code'] = imageQrCode;

      activityResult['route'] =
          activityResult['activity_route']['name'] as String;

      activityResult['is_checked'] = false;
      activityResult['goods'].map((e) {
        final imagePath = e['image'].split('/').last;
        e['image'] = "${_api.baseUrl}/images/barang/$imagePath";
      }).toList();
      return ActivityModel.fromMap(activityResult);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ActivityModel> updateActivity({
    required ActivityModel activity,
    required List<ShipModel> ships,
    required List<ActivityRouteModel> activityRoutes,
  }) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      int shipId =
          ships.firstWhere((element) => element.name == activity.shipName).id;

      int activityRouteId = activityRoutes
          .firstWhere((element) => element.name == activity.route)
          .id;

      // final items = activity.items
      //     .map((e) => ItemModel(
      //           id: e.id,
      //           imagePath: e.imagePath,
      //           image: e.image,
      //           name: e.name,
      //           amount: e.amount,
      //           unit: e.unit,
      //         ))
      //     .toList();

      final result = await _dio.put(
        "${_api.activity.activityDetail}/${activity.id}",
        data: {
          'ship_id': shipId,
          'title': activity.name,
          'start_date': DateFormat('yyyy-MM-dd HH:mm')
              .format(DateTime.parse('${activity.date} ${activity.time}')),
          'jenis_pekerjaan': activity.type,
          'activity_route_id': activityRouteId,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (result.statusCode != 200 && result.statusCode != 201) {
        throw ServerException(
          message: "${result.data['message']}",
          statusCode: result.statusCode,
        );
      }
      final activityResult = result.data['data'] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "Failed to update activity", statusCode: 505);
      }

      for (var i = 0; i < activity.items.length; i++) {
        if (activity.items[i].id != -1) {
          final imageUri = CoreUtils.fileToUriBase64(activity.items[i].image);
          final resultItems = await _dio.put(
            "${_api.items.items}/${activity.items[i].id}",
            data: {
              'name': activity.items[i].name,
              'amount': activity.items[i].amount,
              'unit': activity.items[i].unit,
              'image': imageUri,
            },
            options: Options(
              headers: ApiHeaders.getHeaders(
                token: token,
              ).headers,
              validateStatus: (status) {
                return status! < 500;
              },
            ),
          );

          if (resultItems.statusCode != 200 && result.statusCode != 201) {
            throw const ServerException(
                message: "Failed to update item", statusCode: 400);
          }
        } else {
          final imageUri = CoreUtils.fileToUriBase64(activity.items[i].image);
          final resultItems = await _dio.post(
            _api.items.items,
            data: {
              'activity_id': activity.id,
              'name': activity.items[i].name,
              'amount': activity.items[i].amount,
              'unit': activity.items[i].unit,
              'image': imageUri,
            },
            options: Options(
              headers: ApiHeaders.getHeaders(
                token: token,
              ).headers,
              validateStatus: (status) {
                return status! < 500;
              },
            ),
          );

          if (resultItems.statusCode != 200 && result.statusCode != 201) {
            throw const ServerException(
                message: "Failed to update item", statusCode: 400);
          }
        }
      }
      final activityItems = activity.items
          .map((e) => ItemModel(
                id: e.id,
                imagePath: e.imagePath,
                image: e.image,
                name: e.name,
                amount: e.amount,
                unit: e.unit,
              ).toMap())
          .toList();
      activityResult['qr_code'] = activity.qrCode;
      activityResult.addEntries({
        MapEntry('goods', activityItems),
        const MapEntry('is_checked', false),
        MapEntry('ship_id', activity.shipName),
        MapEntry('route', activity.route),
        const MapEntry('activity_progress', []),
      });
      debugPrint("activity: ${activityResult['goods']}");

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
          'weight': item.amount,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
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
  Future addPhotoItem({required String type}) async {
    try {
      if (type != "remove") {
        final result = await _imagePicker.pickImage(
          source: (type == "camera") ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 150,
        );

        if (result == null) {
          throw ServerException(
              message: "$type can't be accessed", statusCode: 505);
        }
        final image = File(result.path);
        return image;
      } else {
        return null;
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ShipModel>> getShips() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        _api.ship.ships,
        data: {},
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final shipsResult = result.data['data'] as List<dynamic>?;

      if (shipsResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return shipsResult.map((e) => ShipModel.fromMap(e!)).toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ItemModel>> getItems() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        _api.items.items,
        data: {},
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final itemsResult = result.data['data'] as List<dynamic>?;

      if (itemsResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return itemsResult.map((e) => ItemModel.fromMap(e!)).toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ActivityRouteModel>> getRoutes() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        _api.activityRoute.routes,
        data: {},
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final activityRoutesResult = result.data['data'] as List<dynamic>?;

      if (activityRoutesResult == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return activityRoutesResult
          .map((e) => ActivityRouteModel.fromMap(e!))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
