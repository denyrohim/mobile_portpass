import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class AddDocumentation implements UsecaseWithoutParams<dynamic> {
  const AddDocumentation(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<dynamic> call() => _repository.addDocumentation();
}
