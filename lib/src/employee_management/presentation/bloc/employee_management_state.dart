part of 'employee_management_bloc.dart';

abstract class EmployeeManagementState extends Equatable {
  const EmployeeManagementState();

  @override
  List<Object> get props => [];
}

class EmployeeManagementInitial extends EmployeeManagementState {
  const EmployeeManagementInitial();
}

class EmployeeManagementLoading extends EmployeeManagementState {
  const EmployeeManagementLoading();
}

class EmployeeManagementError extends EmployeeManagementState {
  const EmployeeManagementError(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];
}

class EmployeeManagementUpdating extends EmployeeManagementState {
  const EmployeeManagementUpdating();
}

class UpdateChecked extends EmployeeManagementState {
  const UpdateChecked(this.employees);

  final List<Employee> employees;

  @override
  List<Object> get props => [employees];
}

class DataLoaded extends EmployeeManagementState {
  const DataLoaded(this.employees);

  final List<Employee> employees;

  @override
  List<Object> get props => [employees];
}

class ShowChecked extends EmployeeManagementState {
  const ShowChecked(this.employees);

  final List<Employee> employees;

  @override
  List<Object> get props => [employees];
}

class UnshowChecked extends EmployeeManagementState {
  const UnshowChecked(this.employees);

  final List<Employee> employees;

  @override
  List<Object> get props => [employees];
}

class SelectedAll extends EmployeeManagementState {
  const SelectedAll(this.employees);

  final List<Employee> employees;

  @override
  List<Object> get props => [employees];
}

class DataAdded extends EmployeeManagementState {
  const DataAdded();
}

class DataDeleted extends EmployeeManagementState {
  const DataDeleted();
}

class DataUpdated extends EmployeeManagementState {
  const DataUpdated();
}