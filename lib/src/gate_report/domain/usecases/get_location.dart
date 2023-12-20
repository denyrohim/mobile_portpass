import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class GetLocation implements UsecaseWithParams<bool, GetLocationParams> {
  const GetLocation(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<bool> call(GetLocationParams params) => _repository.getLocation(
        longitude: params.longitude,
        latitude: params.latitude,
      );
}

class GetLocationParams extends Equatable {
  const GetLocationParams({
    required this.longitude,
    required this.latitude,
  });

  const GetLocationParams.empty()
      : longitude = 0,
        latitude = 0;

  final double? longitude;
  final double? latitude;

  @override
  List<Object?> get props => [longitude, latitude];
}
