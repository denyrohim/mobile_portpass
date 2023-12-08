import 'package:latlng/latlng.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class GetLocation implements UsecaseWithoutParams<LatLng> {
  const GetLocation(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<LatLng> call() => _repository.getLocation();
}
