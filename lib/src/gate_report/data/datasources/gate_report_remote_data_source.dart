// ignore_for_file: unused_field

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlng/latlng.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/src/gate_report/data/models/activity_model.dart';
import 'package:port_pass_app/src/gate_report/data/models/activity_progress_model.dart';
import 'package:port_pass_app/src/gate_report/data/models/report_model.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GateReportRemoteDataSource {
  const GateReportRemoteDataSource();

  Future<ActivityModel> getActivity({
    required int activityId,
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
      final String dateTime = reportData.dateTime.toString().split(' ')[0];
      debugPrint('dateTime: $dateTime');
      // final result = await _dio.post(
      //   _api.report.report,
      //   data: {
      //     "activity_id": activityId,
      //     "urgent_letter": reportData.urgentLetter,
      //     "documentation": reportData.documentation,
      //     "date_time": dateTime
      //   },
      //   options: Options(
      //     headers: ApiHeaders.getHeaders(
      //       token: token,
      //     ).headers,
      //     receiveDataWhenStatusError: true,
      //     validateStatus: (status) {
      //       return status! < 500;
      //     },
      //   ),
      // );
      // debugPrint(result.toString());
      // if (result.statusCode != 200) {
      //   throw ServerException(
      //       message: result.data['message'] ?? "Data tidak terkirim",
      //       statusCode: result.statusCode ?? 505);
      // }

      // var activityData = result.data['data'] as DataMap?;
      // if (activityData == null) {
      //   throw const ServerException(
      //       message: "Please try again later", statusCode: 505);
      // }
      // return ActivityModel.fromMap(activityData);
      return const ActivityModel(
        id: 1,
        name: "Activity",
        shipName: "Ship ",
        type: "Memasukkan Barang",
        date: "Date ",
        time: "Time ",
        items: [
          Item(
            image: MediaRes.itemExample,
            name: "Masako",
            amount: 10,
            unit: 'ton',
          ),
          Item(
            image: MediaRes.itemExample,
            name: "Masako",
            amount: 10,
            unit: 'ton',
          ),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
        ],
        status: "Diterima",
        activityProgress: [
          ActivityProgressModel(
            name: "ActivityProgress ",
            date: "Date ",
            time: "Time ",
            status: "Status ",
          ),
          ActivityProgressModel(
            name: "ActivityProgress ",
            date: "Date ",
            time: "Time ",
            status: "Status ",
          ),
        ],
        qrCode: "QrCode ",
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ActivityModel> getActivity({required int activityId}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }
      // final result = await _dio.get(
      //   "${_api.activity.activities}/$activityId",
      //   options: Options(
      //     headers: ApiHeaders.getHeaders(
      //       token: token,
      //     ).headers,
      //     receiveDataWhenStatusError: true,
      //     validateStatus: (status) {
      //       return status! < 500;
      //     },
      //   ),
      // );

      // if (result.statusCode != 200) {
      //   throw ServerException(
      //       message: result.data['message'] ?? "Data tidak terkirim",
      //       statusCode: result.statusCode ?? 505);
      // }

      // var activityData = result.data['data'] as DataMap?;
      // if (activityData == null) {
      //   throw const ServerException(
      //       message: "Please try again later", statusCode: 505);
      // }

      // return ActivityModel.fromMap(activityData);

      return const ActivityModel(
        id: 1,
        name: "Activity",
        shipName: "Ship ",
        type: "Memasukkan Barang",
        date: "Date ",
        time: "Time ",
        items: [
          Item(
            image: MediaRes.itemExample,
            name: "Masako",
            amount: 10,
            unit: 'ton',
          ),
          Item(
            image: MediaRes.itemExample,
            name: "Masako",
            amount: 10,
            unit: 'ton',
          ),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
          Item(
              image: MediaRes.itemExample,
              name: "Masako",
              amount: 10,
              unit: 'ton'),
        ],
        status: "Diterima",
        activityProgress: [
          ActivityProgressModel(
            name: "ActivityProgress ",
            date: "Date ",
            time: "Time ",
            status: "Status ",
          ),
          ActivityProgressModel(
            name: "ActivityProgress ",
            date: "Date ",
            time: "Time ",
            status: "Status ",
          ),
        ],
        qrCode: "QrCode ",
      );
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
            message: "storage can't be accessed", statusCode: 505);
      }
      final image = File(result.files.single.path!);
      return image;
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

      debugPrint('latLng: ${latLng.latitude}, ${latLng.longitude}');

      double distance = Geolocator.distanceBetween(
          latLng.latitude, latLng.longitude, latitude, longitude);

      if (distance <= 300) {
        return true;
      } else {
        throw const ServerException(
            message: "You are not in the location", statusCode: 400);
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
