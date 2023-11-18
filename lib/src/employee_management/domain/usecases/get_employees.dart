import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class GetEmployees implements UsecaseWithoutParams<List<Employee>> {
  const GetEmployees(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<List<Employee>> call() => _repository.getEmployees();
}
