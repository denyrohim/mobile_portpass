import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class ScanNFCEmployee implements UsecaseWithoutParams<String> {
  const ScanNFCEmployee(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<String> call() => _repository.scanNFCEmployee();
}
