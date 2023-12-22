import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class AddReport implements UsecaseWithParams<Activity, AddReportParams> {
  const AddReport(this._repository);

  final GateReportRepository _repository;

  @override
  ResultFuture<Activity> call(AddReportParams params) => _repository.addReport(
        activityId: params.activityId,
        reportData: params.reportData,
      );
}

class AddReportParams extends Equatable {
  const AddReportParams({
    required this.activityId,
    required this.reportData,
  });

  const AddReportParams.empty()
      : activityId = 0,
        reportData = const Report.empty();

  final int activityId;
  final Report reportData;

  @override
  List<Object?> get props => [activityId, reportData];
}
