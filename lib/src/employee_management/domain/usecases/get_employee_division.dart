import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class GetEmployeeDivision
    implements UsecaseWithoutParams<List<EmployeeDivision>> {
  const GetEmployeeDivision(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<List<EmployeeDivision>> call() =>
      _repository.getEmployeeDivision();
}
