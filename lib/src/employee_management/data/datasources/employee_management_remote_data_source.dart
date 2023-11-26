import 'package:dio/dio.dart';
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
    required UpdateEmployeeAction action,
    required EmployeeModel employeeData,
  });
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
      {required UpdateEmployeeAction action,
      required EmployeeModel employeeData}) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final data = <String, dynamic>{};
      switch (action) {
        case UpdateEmployeeAction.name:
          data["name"] = employeeData.name;
          break;
        case UpdateEmployeeAction.nik:
          data["nik"] = employeeData.nik;
          break;
        case UpdateEmployeeAction.phone:
          data["phone"] = employeeData.phone;
          break;
        case UpdateEmployeeAction.email:
          data["email"] = employeeData.email;
          break;
        case UpdateEmployeeAction.employeeType:
          data["jenis_karyawan"] = employeeData.employeeType;
          break;
        case UpdateEmployeeAction.employeeDivisionId:
          data["bagian_id"] = employeeData.employeeDivisionId;
          break;
        case UpdateEmployeeAction.cardNumber:
          data["card_number"] = employeeData.cardNumber;
          break;
        case UpdateEmployeeAction.cardStart:
          data["card_start"] = employeeData.cardStart;
          break;
        case UpdateEmployeeAction.cardStop:
          data["card_stop"] = employeeData.cardStop;
          break;
        case UpdateEmployeeAction.dateOfBirth:
          data["date_of_birth"] = employeeData.dateOfBirth;
          break;
        case UpdateEmployeeAction.photo:
          data["photo"] = employeeData.photo;
          break;
      }
      final result = await _dio.put(
        _api.employee.employees,
        data: data,
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
        ),
      );
      final employee = result.data['data']['employee'] as DataMap?;
      if (employee == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return EmployeeModel.fromMap(employee);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
