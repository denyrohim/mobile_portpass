import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/enums/update_employee_action.dart';

import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/add_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/cancel_check_box_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/delete_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/get_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/scan_nfc_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/select_all_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_check_box_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_employee.dart';

part 'employee_management_event.dart';
part 'employee_management_state.dart';

class EmployeeManagementBloc
    extends Bloc<EmployeeManagementEvent, EmployeeManagementState> {
  EmployeeManagementBloc({
    required AddEmployee addEmployee,
    required DeleteEmployees deleteEmployees,
    required UpdateEmployee updateEmployee,
    required GetEmployees getEmployees,
    required UpdateCheckBoxEmployee updateCheckBoxEmployee,
    required CancelCheckBoxEmployees cancelCheckBoxEmployees,
    required SelectAllEmployees selectAllEmployees,
    required ScanNFCEmployee scanNFCEmployee,
  })  : _addEmployee = addEmployee,
        _deleteEmployees = deleteEmployees,
        _updateEmployee = updateEmployee,
        _getEmployees = getEmployees,
        _updateCheckBoxEmployee = updateCheckBoxEmployee,
        _cancelCheckBoxEmployees = cancelCheckBoxEmployees,
        _selectAllEmployees = selectAllEmployees,
        _scanNFCEmployee = scanNFCEmployee,
        super(const EmployeeManagementInitial()) {
    on<EmployeeManagementEvent>((event, emit) {
      emit(const EmployeeManagementLoading());
    });
    on<AddEmployeeEvent>(_addEmployeeHandler);
    on<DeleteEmployeesEvent>(_deleteEmployeesHandler);
    on<GetEmployeesEvent>(_getEmployeesHandler);
    on<UpdateEmployeeEvent>(_updateEmployeeHandler);
    on<UpdateCheckBoxEmployeeEvent>(_updateCheckBoxEmployeeHandler);
    on<CancelCheckBoxEmployeeEvent>(_cancelCheckBoxEmployeeHandler);
    on<SelectAllEmployeesEvent>(_selectAllEmployeesHandler);
    on<ScanNFCEmployeeEvent>(_scanNFCEmployeeHandler);
  }
  final AddEmployee _addEmployee;
  final DeleteEmployees _deleteEmployees;
  final UpdateEmployee _updateEmployee;
  final GetEmployees _getEmployees;
  final UpdateCheckBoxEmployee _updateCheckBoxEmployee;
  final CancelCheckBoxEmployees _cancelCheckBoxEmployees;
  final SelectAllEmployees _selectAllEmployees;
  final ScanNFCEmployee _scanNFCEmployee;

  Future<void> _addEmployeeHandler(
    AddEmployeeEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _addEmployee(
      event.employeeData,
    );
    result.fold(
      (failure) => emit(EmployeeManagementError(failure.errorMessage)),
      (_) => emit(const DataAdded()),
    );
  }

  Future<void> _deleteEmployeesHandler(
    DeleteEmployeesEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _deleteEmployees(
      event.employeesIds,
    );
    result.fold(
      (failure) => emit(EmployeeManagementError(failure.errorMessage)),
      (_) => emit(const DataDeleted()),
    );
  }

  Future<void> _getEmployeesHandler(
    GetEmployeesEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _getEmployees();
    result.fold(
      (failure) => emit(EmployeeManagementError(failure.errorMessage)),
      (employees) => emit(DataLoaded(employees)),
    );
  }

  Future<void> _updateEmployeeHandler(
    UpdateEmployeeEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _updateEmployee(UpdateEmployeeParams(
      actions: event.actions,
      employee: event.employee,
    ));
    result.fold(
      (failure) => emit(EmployeeManagementError(failure.errorMessage)),
      (employee) => emit(DataUpdated(employee)),
    );
  }

  Future<List<Employee>> _updateCheckBoxEmployeeHandler(
    UpdateCheckBoxEmployeeEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _updateCheckBoxEmployee(UpdateCheckBoxEmployeeParams(
      employeeId: event.employeeId,
      employees: event.employees,
    ));
    return result.fold(
      (failure) {
        emit(EmployeeManagementError(failure.errorMessage));
        return event.employees;
      },
      (employees) {
        emit(UpdateChecked(employees));
        return employees;
      },
    );
  }

  Future<List<Employee>> _cancelCheckBoxEmployeeHandler(
    CancelCheckBoxEmployeeEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _cancelCheckBoxEmployees(
      event.employees,
    );
    return result.fold(
      (failure) {
        emit(EmployeeManagementError(failure.errorMessage));
        return event.employees;
      },
      (employees) {
        emit(UnshowChecked(employees));
        return employees;
      },
    );
  }

  Future<List<Employee>> _selectAllEmployeesHandler(
    SelectAllEmployeesEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _selectAllEmployees(
      event.employees,
    );
    return result.fold(
      (failure) {
        emit(EmployeeManagementError(failure.errorMessage));
        return event.employees;
      },
      (employees) {
        emit(SelectedAll(employees));
        return employees;
      },
    );
  }

  Future<void> _scanNFCEmployeeHandler(
    ScanNFCEmployeeEvent event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final result = await _scanNFCEmployee();
    return result.fold(
      (failure) => emit(NFCScanFailed(failure.errorMessage)),
      (nfcNumber) => emit(NFCScanSuccess(nfcNumber)),
    );
  }
}
