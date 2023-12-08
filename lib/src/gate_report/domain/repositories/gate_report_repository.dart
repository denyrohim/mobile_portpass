import 'package:latlng/latlng.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';

abstract class GateReportRepository {
  const GateReportRepository();

  ResultFuture<Activity> getActivity({
    required int activityId,
  });

  ResultFuture<int> scanQRActivity();

  ResultFuture<LatLng> getLocation();

  ResultFuture<Activity> addReport({
    required int activityId,
    required Report reportData,
  });

  ResultFuture<dynamic> addUrgentLetter();

  ResultFuture<dynamic> addDocumentation();
}
