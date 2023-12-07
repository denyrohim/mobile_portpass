import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';

class AddPhotoEmployee implements UsecaseWithParams<dynamic, String> {
  const AddPhotoEmployee(this._repository);

  final EmployeeManagementRepository _repository;

  @override
  ResultFuture<dynamic> call(String type) => _repository.addPhoto(
        type: type,
      );
}
