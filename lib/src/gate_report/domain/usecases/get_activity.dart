import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class GetActivity implements UsecaseWithParams<Activity, int> {
  const GetActivity(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<Activity> call(int activityId) => _repository.getActivity(
        activityId: activityId,
      );
}
