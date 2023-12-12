import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/location.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class GetLocation implements UsecaseWithoutParams<Location> {
  const GetLocation(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<Location> call() => _repository.getLocation();
}
