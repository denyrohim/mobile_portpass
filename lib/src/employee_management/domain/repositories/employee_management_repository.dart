import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

abstract class EmployeeManagementRepository {
  const EmployeeManagementRepository();

  ResultFuture<void> addEmployee({
    required dynamic employeeData,
  });

  ResultFuture<void> deleteEmployees({
    required List<int> ids,
  });

  ResultFuture<List<Employee>> getEmployees();

  ResultFuture<Employee> updateEmployee({
    required UpdateEmployeeAction action,
    required dynamic employeeData,
  });
}
