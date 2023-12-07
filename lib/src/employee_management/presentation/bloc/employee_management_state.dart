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
  const DataUpdated(this.employee);

  final Employee employee;

  @override
  List<Object> get props => [employee];
}

class NFCScanSuccess extends EmployeeManagementState {
  const NFCScanSuccess(this.nfcNumber);

  final String nfcNumber;

  @override
  List<Object> get props => [nfcNumber];
}

class NFCScanFailed extends EmployeeManagementState {
  const NFCScanFailed(this.failureMessage);

  final String failureMessage;

  @override
  List<Object> get props => [failureMessage];
}

class PhotoAdded extends EmployeeManagementState {
  const PhotoAdded(this.photo);

  final dynamic photo;

  @override
  List<Object> get props => [photo];
}

class EmployeeDivisionLoaded extends EmployeeManagementState {
  const EmployeeDivisionLoaded(this.employeeDivisions);

  final List<EmployeeDivision> employeeDivisions;

  @override
  List<Object> get props => [employeeDivisions];
}
