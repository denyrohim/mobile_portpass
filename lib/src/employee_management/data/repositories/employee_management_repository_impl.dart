import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import 'package:port_pass_app/src/employee_management/data/datasources/employee_management_remote_data_source.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_model.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class EmployeeManagementRepositoryImpl implements EmployeeManagementRepository {
  const EmployeeManagementRepositoryImpl(this._remoteDataSource);

  final EmploymentManagementRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addEmployee({required employeeData}) async {
    try {
      final employeeModel = EmployeeModel(
        id: employeeData.id,
        name: employeeData.name,
        email: employeeData.email,
        phone: employeeData.phone,
        dateOfBirth: employeeData.dateOfBirth,
        employeeDivisionId: employeeData.employeeDivisionId,
        employeeType: employeeData.employeeType,
        nik: employeeData.nik,
        cardStart: employeeData.cardStart,
        cardStop: employeeData.cardStop,
        cardNumber: employeeData.cardNumber,
        photo: employeeData.photo,
        isChecked: employeeData.isChecked,
      );
      final result = await _remoteDataSource.addEmployee(
        employeeData: employeeModel,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteEmployees({required List<int> ids}) async {
    try {
      final result = await _remoteDataSource.deleteEmployees(
        ids: ids,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Employee>> getEmployees() async {
    try {
      final result = await _remoteDataSource.getEmployees();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Employee> updateEmployee(
      {required List<UpdateEmployeeAction> actions,
      required Employee employee}) async {
    try {
      // final EmployeeModel employeeModel = employee as EmployeeModel;

      final employeeModel = EmployeeModel(
        id: employee.id,
        name: employee.name,
        email: employee.email,
        phone: employee.phone,
        dateOfBirth: employee.dateOfBirth,
        employeeDivisionId: employee.employeeDivisionId,
        employeeType: employee.employeeType,
        nik: employee.nik,
        cardStart: employee.cardStart,
        cardStop: employee.cardStop,
        cardNumber: employee.cardNumber,
        photo: employee.photo,
        isChecked: employee.isChecked,
      );
      final result = await _remoteDataSource.updateEmployee(
        actions: actions,
        employee: employeeModel,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Employee>> updateCheckBoxEmployee(
      {required employeeId, required employees}) {
    try {
      final EmployeeModel employee = employees[employeeId] as EmployeeModel;
      final newEmployee = employee.copyWith(isChecked: !employee.isChecked);
      final List<Employee> result = [];
      for (int i = 0; i < employees.length; i++) {
        if (i == employeeId) {
          result.add(newEmployee);
        } else {
          result.add(employees[i]);
        }
      }
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<List<Employee>> cancelCheckBoxEmployees(
      {required List<Employee> employees}) {
    try {
      final List<Employee> result = [];
      for (int i = 0; i < employees.length; i++) {
        final EmployeeModel employee = employees[i] as EmployeeModel;
        final newEmployee = employee.copyWith(isChecked: false);
        result.add(newEmployee);
      }
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<List<Employee>> selectAllEmployees(
      {required List<Employee> employees}) {
    try {
      final List<Employee> result = [];
      for (int i = 0; i < employees.length; i++) {
        final EmployeeModel employee = employees[i] as EmployeeModel;
        final newEmployee = employee.copyWith(isChecked: true);
        result.add(newEmployee);
      }
      return Future.value(Right(result));
    } on ServerException catch (e) {
      return Future.value(Left(ServerFailure.fromException(e)));
    }
  }

  @override
  ResultFuture<String> scanNFCEmployee() async {
    try {
      final result = await _remoteDataSource.scanNFCEmployee();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<dynamic> addPhoto({required String type}) async {
    try {
      final result = await _remoteDataSource.addPhoto(type: type);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<EmployeeDivision>> getEmployeeDivision() async {
    try {
      final result = await _remoteDataSource.getEmployeeDivision();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
