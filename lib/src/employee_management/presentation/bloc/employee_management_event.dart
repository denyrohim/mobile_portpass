part of 'employee_management_bloc.dart';

abstract class EmployeeManagementEvent extends Equatable {
  const EmployeeManagementEvent();
}

class AddEmployeeEvent extends EmployeeManagementEvent {
  const AddEmployeeEvent({
    required this.employeeData,
  });

  final Employee employeeData;

  @override
  List<Object> get props => [employeeData];
}

class DeleteEmployeesEvent extends EmployeeManagementEvent {
  const DeleteEmployeesEvent({
    required this.employeesIds,
  });

  final List<int> employeesIds;

  @override
  List<Object> get props => [employeesIds];
}

class GetEmployeesEvent extends EmployeeManagementEvent {
  const GetEmployeesEvent();

  @override
  List<Object> get props => [];
}

class UpdateEmployeeEvent extends EmployeeManagementEvent {
  const UpdateEmployeeEvent({
    required this.actions,
    required this.employee,
  });

  final List<UpdateEmployeeAction> actions;
  final Employee employee;

  @override
  List<Object> get props => [actions, employee];
}

class UpdateCheckBoxEmployeeEvent extends EmployeeManagementEvent {
  const UpdateCheckBoxEmployeeEvent({
    required this.employeeId,
    required this.employees,
  });

  final int employeeId;
  final List<Employee> employees;

  @override
  List<Object> get props => [employeeId, employees];
}

class CancelCheckBoxEmployeeEvent extends EmployeeManagementEvent {
  const CancelCheckBoxEmployeeEvent({
    required this.employees,
  });

  final List<Employee> employees;
  @override
  List<Object> get props => [employees];
}

class SelectAllEmployeesEvent extends EmployeeManagementEvent {
  const SelectAllEmployeesEvent({
    required this.employees,
  });

  final List<Employee> employees;
  @override
  List<Object> get props => [employees];
}

class ScanNFCEmployeeEvent extends EmployeeManagementEvent {
  const ScanNFCEmployeeEvent();

  @override
  List<Object> get props => [];
}
