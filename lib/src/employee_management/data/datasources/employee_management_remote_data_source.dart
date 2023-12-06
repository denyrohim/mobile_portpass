import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_division_model.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class EmploymentManagementRemoteDataSource {
  const EmploymentManagementRemoteDataSource();

  Future<void> addEmployee({
    required EmployeeModel employeeData,
  });
  Future<void> deleteEmployees({
    required List<int> ids,
  });
  Future<List<EmployeeModel>> getEmployees();
  Future<EmployeeModel> updateEmployee({
    required List<UpdateEmployeeAction> actions,
    required EmployeeModel employee,
  });
  Future<String> scanNFCEmployee();
  Future<dynamic> addPhoto({
    required String type,
  });

  Future<List<EmployeeDivisionModel>> getEmployeeDivision();
}

const kToken = 'token';

class EmploymentManagementRemoteDataSourceImpl
    implements EmploymentManagementRemoteDataSource {
  const EmploymentManagementRemoteDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required Dio dio,
    required API api,
    required ImagePicker imagePicker,
  })  : _dio = dio,
        _api = api,
        _sharedPreferences = sharedPreferences,
        _imagePicker = imagePicker;

  final SharedPreferences _sharedPreferences;
  final Dio _dio;
  final API _api;
  final ImagePicker _imagePicker;

  @override
  Future<void> addEmployee({required EmployeeModel employeeData}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }
      final result = await _dio.post(
        _api.employee.employees,
        data: {
          "bagian_id": employeeData.employeeDivisionId,
          "name": employeeData.name,
          "nip": null,
          "date_of_birth": employeeData.dateOfBirth,
          "address": null,
          "place_of_birth": null,
          "phone": employeeData.phone,
          "email": employeeData.email,
          "photo": employeeData.photo,
          "gender": null,
          "nik": employeeData.nik,
          "jenis_karyawan": employeeData.employeeType,
          "card_number": employeeData.cardNumber,
          "card_start": employeeData.cardStart,
          "card_stop": employeeData.cardStop,
        },
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          // receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return true;
          },
        ),
      );

      if (result.statusCode != 200) {
        throw ServerException(
            message: result.data['message'] ?? "Data tidak terkirim",
            statusCode: result.statusCode ?? 505);
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deleteEmployees({required List<int> ids}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.post(
        "${_api.employee.employees}/delete-list",
        data: {
          "ids": ids,
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
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        _api.employee.employees,
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final listEmployees = result.data['data'] as List?;
      if (listEmployees == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      var employees = listEmployees.map((e) => e as DataMap).toList();
      // change photo path
      employees = employees.map((e) {
        final photo = e['photo'] as String?;
        if (photo != null) {
          if (photo.split('/').first == "https:") {
            e['photo'] = null;
          } else {
            final photoPath = photo.split('/').last;

            e['photo'] = "${_api.baseUrl}/images/employee/$photoPath";
          }
        }
        return e;
      }).toList();

      // final employees =
      //     List.generate(20, (index) => const EmployeeModel.empty());

      return List<EmployeeModel>.from(
        employees.map(
          (e) => EmployeeModel.fromMap(e),
        ),
      );
      // return employees;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<EmployeeModel> updateEmployee(
      {required List<UpdateEmployeeAction> actions,
      required EmployeeModel employee}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final data = <String, dynamic>{};
      for (final action in actions) {
        switch (action) {
          case UpdateEmployeeAction.name:
            data["name"] = employee.name;
            break;
          case UpdateEmployeeAction.nik:
            data["nik"] = employee.nik;
            break;
          case UpdateEmployeeAction.phone:
            data["phone"] = employee.phone;
            break;
          case UpdateEmployeeAction.email:
            data["email"] = employee.email;
            break;
          case UpdateEmployeeAction.employeeType:
            data["jenis_karyawan"] = employee.employeeType;
            break;
          case UpdateEmployeeAction.employeeDivisionId:
            data["bagian_id"] = employee.employeeDivisionId;
            break;
          case UpdateEmployeeAction.cardNumber:
            data["card_number"] = employee.cardNumber;
            break;
          case UpdateEmployeeAction.cardStart:
            data["card_start"] = employee.cardStart;
            break;
          case UpdateEmployeeAction.cardStop:
            data["card_stop"] = employee.cardStop;
            break;
          case UpdateEmployeeAction.dateOfBirth:
            data["date_of_birth"] = employee.dateOfBirth;
            break;
          case UpdateEmployeeAction.photo:
            data["photo"] = employee.photo;
            break;
        }
      }

      final result = await _dio.put(
        "${_api.employee.employees}/${employee.id}",
        data: data,
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      var employeeData = result.data['data'] as DataMap?;
      if (employeeData == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      // change photo path
      final photoPath = employeeData['photo'].split('/').last;
      employeeData['photo'] = "${_api.baseUrl}/images/employee/$photoPath}";

      return EmployeeModel.fromMap(employeeData);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<String> scanNFCEmployee() async {
    try {
      var availability = await FlutterNfcKit.nfcAvailability;
      if (availability != NFCAvailability.available) {
        throw const ServerException(
            message: "Doesn't support NFC", statusCode: 400);
      }
      var tag = await FlutterNfcKit.poll(
          timeout: const Duration(seconds: 20),
          iosMultipleTagMessage: "Multiple tags found!",
          iosAlertMessage: "Scan your tag");

      // Call finish() only once
      await FlutterNfcKit.finish();
      // iOS only: show alert/error message on finish
      await FlutterNfcKit.finish(iosAlertMessage: "Success");
      await FlutterNfcKit.finish(iosErrorMessage: "Failed");
      return Future.value(tag.applicationData);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<dynamic> addPhoto({required String type}) async {
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
  Future<List<EmployeeDivisionModel>> getEmployeeDivision() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final result = await _dio.get(
        _api.employee.employeeDivision,
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final listEmployeeDivision = result.data['data'] as List?;
      if (listEmployeeDivision == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      final employeeDivision =
          listEmployeeDivision.map((e) => e as DataMap).toList();
      // final employees =
      //     List.generate(20, (index) => const EmployeeModel.empty());

      return List<EmployeeDivisionModel>.from(
        employeeDivision.map(
          (e) => EmployeeDivisionModel.fromMap(e),
        ),
      );
      // return employees;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
