import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class GetActivity implements UsecaseWithParams<Activity, String> {
  const GetActivity(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<Activity> call(String activityCode) => _repository.getActivity(
        activityCode: activityCode,
      );
}
