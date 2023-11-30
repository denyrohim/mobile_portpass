import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class AddPhoto implements UsecaseWithParams<dynamic, String> {
  const AddPhoto(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<dynamic> call(String type) => _repository.addPhoto(
        type: type,
      );
}
