import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_model.dart';
import 'package:port_pass_app/src/gate_report/data/models/report_model.dart';
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
}

const kToken = 'token';

class GateReportRemoteDataSourceImpl implements GateReportRemoteDataSource {
  const GateReportRemoteDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required Dio dio,
    required API api,
    required FilePicker filePicker,
  })  : _dio = dio,
        _api = api,
        _sharedPreferences = sharedPreferences,
        _filePicker = filePicker;

  final SharedPreferences _sharedPreferences;
  final Dio _dio;
  final API _api;
  final FilePicker _filePicker;

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
          "location": reportData.location,
          "urgent_letter": reportData.urgentLetter,
          "documentation": reportData.documentation,
          "date_time": reportData.dateTime
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
  Future<ActivityModel> getActivity({required int activityId}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }
      final result = await _dio.get(
        "${_api.activity.activities}/$activityId",
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
  Future addDocumentation() async {
    try {
      final result = await _filePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
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
  Future addUrgentLetter() async {
    try {
      final result = await _filePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'jpeg'],
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
}
