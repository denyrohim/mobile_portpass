import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class DeleteEmployees implements UsecaseWithParams<void, List<int>> {
  const DeleteEmployees(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<void> call(List<int> ids) => _repository.deleteEmployees(
        ids: ids,
      );
}
