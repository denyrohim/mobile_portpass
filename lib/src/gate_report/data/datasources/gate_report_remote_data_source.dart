import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlng/latlng.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/data/models/activity_model.dart';
import 'package:port_pass_app/src/gate_report/data/models/report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/core_utils.dart';
import '../../../../core/utils/headers.dart';
import '../../../activity_management/data/models/ship_model.dart';

abstract class GateReportRemoteDataSource {
  const GateReportRemoteDataSource();

  Future<ActivityModel> getActivity({
    required String activityCode,
    required List<ShipModel> ships,
  });
  Future<ActivityModel> addReport({
    required int activityId,
    required ReportModel reportData,
  });

  Future<dynamic> addUrgentLetter();

  Future<dynamic> addDocumentation();

  Future<bool> getLocation({
    required double? longitude,
    required double? latitude,
  });

  Future<List<ShipModel>> getShips();
}

const kToken = 'token';

class GateReportRemoteDataSourceImpl implements GateReportRemoteDataSource {
  const GateReportRemoteDataSourceImpl(
      {required SharedPreferences sharedPreferences,
      required Dio dio,
      required API api,
      required FilePicker filePicker,
      required ImagePicker imagePicker,
      required GeolocatorPlatform geolocator})
      : _dio = dio,
        _api = api,
        _sharedPreferences = sharedPreferences,
        _filePicker = filePicker,
        _imagePicker = imagePicker,
        _geolocator = geolocator;

  final SharedPreferences _sharedPreferences;
  final Dio _dio;
  final API _api;
  final FilePicker _filePicker;
  final ImagePicker _imagePicker;
  final GeolocatorPlatform _geolocator;

  @override
  Future<ActivityModel> addReport(
      {required int activityId, required ReportModel reportData}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }
      final result = await _dio.post(
        _api.report.report,
        data: {
          "activity_id": activityId,
          "name": reportData.name,
          "urgent_letter": reportData.urgentLetter,
          "documentation": reportData.documentation,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      debugPrint(result.toString());
      if (result.statusCode != 200) {
        throw ServerException(
            message: result.data['message'] ?? "Data tidak terkirim",
            statusCode: result.statusCode ?? 505);
      }

      var activityData = result.data['data'] as DataMap?;
      if (activityData == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      return ActivityModel.fromMap(activityData);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ActivityModel> getActivity({
    required String activityCode,
    required List<ShipModel> ships,
  }) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        "${_api.activity.activityDetail}?include=goods,activityProgress,activityRoute&filter[code]=$activityCode",
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      final activityResult = result.data['data'][0] as DataMap?;

      if (activityResult == null) {
        throw const ServerException(
            message: "There is no activity with this QRCode", statusCode: 505);
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
        final imagePath = e['image'];
        e['image'] = "${_api.baseUrl}/images/barang/$imagePath";
      }).toList();
      activityResult['activity_progress'].map((e) {
        final imagePath = e['image'];
        e['image'] = "${_api.baseUrl}/images/progress/$imagePath";
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
  Future addDocumentation() async {
    try {
      final result = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 850,
      );

      if (result == null) {
        throw const ServerException(
            message: "Camera can't be accessed", statusCode: 505);
      }
      final image = File(result.path);
      final sizePass = CoreUtils.checkSizeFile(2, image);
      if (!sizePass) {
        throw const ServerException(
            message: "image is larger than 2Mb", statusCode: 413);
      }
      return image;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future addUrgentLetter() async {
    try {
      final result = await _filePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'jpeg'],
        allowCompression: true,
      );

      if (result == null) {
        throw const ServerException(
            message: "storage can't be accessed", statusCode: 403);
      }
      final file = File(result.files.single.path!);
      final sizePass = CoreUtils.checkSizeFile(2, file);
      if (!sizePass) {
        throw const ServerException(
            message: "file is larger than 2Mb", statusCode: 413);
      }
      return file;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<bool> getLocation({
    required double? longitude,
    required double? latitude,
  }) async {
    try {
      if (latitude == null || longitude == null) {
        throw const ServerException(
            message: "User doesn't have location yet", statusCode: 403);
      }
      LocationPermission permission;
      permission = await _geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw const ServerException(
            message: "Location permission denied", statusCode: 505);
      }
      final latLng = await _geolocator
          .getCurrentPosition()
          .then((value) => LatLng(value.latitude, value.longitude));

      double distance = Geolocator.distanceBetween(
          latLng.latitude, latLng.longitude, latitude, longitude);

      if (distance <= 300) {
        return true;
      } else {
        if (distance > 1000) {
          distance = distance / 1000;
          distance = double.parse(distance.toStringAsFixed(2));
          throw ServerException(
              message: "You are not in the location ($distance km away)",
              statusCode: 400);
        } else {
          distance = double.parse(distance.toStringAsFixed(2));
          throw ServerException(
              message: "You are not in the location ($distance) m away",
              statusCode: 400);
        }
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
}
