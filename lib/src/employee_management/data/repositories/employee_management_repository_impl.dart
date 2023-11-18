import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import 'package:port_pass_app/src/employee_management/data/datasources/employee_management_data_source.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class EmployeeManagementRepositoryImpl implements EmployeeManagementRepository {
  const EmployeeManagementRepositoryImpl(this._remoteDataSource);

  final EmploymentManagementRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addEmployee({required employeeData}) async {
    try {
      final result = await _remoteDataSource.addEmployee(
        employeeData: employeeData,
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
      {required UpdateEmployeeAction action, required employeeData}) async {
    try {
      final result = await _remoteDataSource.updateEmployee(
        action: action,
        employeeData: employeeData,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
