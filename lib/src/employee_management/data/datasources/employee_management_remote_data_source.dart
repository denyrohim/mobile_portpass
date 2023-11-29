import 'package:dio/dio.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
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
}

const kToken = 'token';

class EmploymentManagementRemoteDataSourceImpl
    implements EmploymentManagementRemoteDataSource {
  const EmploymentManagementRemoteDataSourceImpl({
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
  Future<void> addEmployee({required EmployeeModel employeeData}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      await _dio.post(
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
  Future<void> deleteEmployees({required List<int> ids}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      await _dio.delete(
        _api.employee.employees,
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
        ),
      );
      final listEmployees = result.data['data'] as List?;
      if (listEmployees == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      final employees = listEmployees.map((e) => e as DataMap).toList();
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
      debugPrint("data: $data");
      debugPrint('employeeId: ${employee.id}');

      final result = await _dio.put(
        "${_api.employee.employees}/${employee.id}",
        data: data,
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
      final employeeData = result.data['data'] as DataMap?;
      if (employeeData == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return EmployeeModel.fromMap(employee.toMap());
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

      late final String result;
      if (tag.type == NFCTagType.iso7816) {
        result = await FlutterNfcKit.transceive(
          "00B0950000",
          timeout: const Duration(seconds: 5),
        ); // timeout is still Android-only, persist until next change
      }
      // iOS only: set alert message on-the-fly
      // this will persist until finish()
      // await FlutterNfcKit.setIosAlertMessage("Proses Scan!");

      // Call finish() only once
      await FlutterNfcKit.finish();
      // iOS only: show alert/error message on finish
      await FlutterNfcKit.finish(iosAlertMessage: "Success");
      await FlutterNfcKit.finish(iosErrorMessage: "Failed");
      return Future.value(result);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
