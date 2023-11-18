import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class UpdateEmployee
    implements UsecaseWithParams<Employee, UpdateEmployeeParams> {
  const UpdateEmployee(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<Employee> call(UpdateEmployeeParams params) =>
      _repository.updateEmployee(
        action: params.action,
        employeeData: params.employeeData,
      );
}

class UpdateEmployeeParams extends Equatable {
  const UpdateEmployeeParams({
    required this.action,
    required this.employeeData,
  });

  const UpdateEmployeeParams.empty()
      : action = UpdateEmployeeAction.name,
        employeeData = '';

  final dynamic employeeData;
  final UpdateEmployeeAction action;

  @override
  List<Object?> get props => [action, employeeData];
}
