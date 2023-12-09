import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class ScanQRActivity implements UsecaseWithoutParams<int> {
  const ScanQRActivity(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<int> call() => _repository.scanQRActivity();
}
