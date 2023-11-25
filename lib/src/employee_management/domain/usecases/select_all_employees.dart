import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class SelectAllEmployees
    implements UsecaseWithParams<List<Employee>, List<Employee>> {
  const SelectAllEmployees(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<List<Employee>> call(List<Employee> employees) =>
      _repository.selectAllEmployees(
        employees: employees,
      );
}
