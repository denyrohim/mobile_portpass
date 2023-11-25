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
    required this.action,
    required this.employeeData,
  });

  final UpdateEmployeeAction action;
  final Employee employeeData;

  @override
  List<Object> get props => [action, employeeData];
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
  List<Object> get props => [];
}

class SelectAllEmployeesEvent extends EmployeeManagementEvent {
  const SelectAllEmployeesEvent({
    required this.employees,
  });

  final List<Employee> employees;
  @override
  List<Object> get props => [];
}
