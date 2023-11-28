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
        actions: params.actions,
        employee: params.employee,
      );
}

class UpdateEmployeeParams extends Equatable {
  const UpdateEmployeeParams({
    required this.actions,
    required this.employee,
  });

  UpdateEmployeeParams.empty()
      : actions = [UpdateEmployeeAction.name],
        employee = const Employee.empty();

  final List<UpdateEmployeeAction> actions;
  final Employee employee;

  @override
  List<Object?> get props => [actions, employee];
}
