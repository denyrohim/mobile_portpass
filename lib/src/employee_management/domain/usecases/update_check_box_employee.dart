import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class UpdateCheckBoxEmployee
    implements UsecaseWithParams<List<Employee>, UpdateCheckBoxEmployeeParams> {
  const UpdateCheckBoxEmployee(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<List<Employee>> call(UpdateCheckBoxEmployeeParams params) =>
      _repository.updateCheckBoxEmployee(
        employeeId: params.employeeId,
        employees: params.employees,
      );
}

class UpdateCheckBoxEmployeeParams extends Equatable {
  const UpdateCheckBoxEmployeeParams({
    required this.employeeId,
    required this.employees,
  });

  UpdateCheckBoxEmployeeParams.empty()
      : employeeId = 0,
        employees = [];

  final int employeeId;
  final List<Employee> employees;

  @override
  List<Object?> get props => [employeeId, employees];
}
