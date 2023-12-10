part of 'gate_report_bloc.dart';

abstract class GateReportState extends Equatable {
  const GateReportState();

  @override
  List<Object> get props => [];
}

class GateReportInitial extends GateReportState {
  const GateReportInitial();
}

class GateReportLoading extends GateReportState {
  const GateReportLoading();
}

class GateReportError extends GateReportState {
  const GateReportError(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];
}

class GateReportUpdating extends GateReportState {
  const GateReportUpdating();
}

class ScanSuccess extends GateReportState {
  const ScanSuccess(this.result);

  final String result;

  @override
  List<Object> get props => [result];
}

class ScanFailed extends GateReportState {
  const ScanFailed(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class DocumentationAdded extends GateReportState {
  const DocumentationAdded(this.photo);

  final dynamic photo;

  @override
  List<Object> get props => [photo];
}

class UrgentLetterAdded extends GateReportState {
  const UrgentLetterAdded(this.file);

  final dynamic file;

  @override
  List<Object> get props => [file];
}

class ReportAdded extends GateReportState {
  const ReportAdded();
}

class ActivityLoaded extends GateReportState {
  const ActivityLoaded(this.activity);

  final Activity activity;

  @override
  List<Object> get props => [activity];
}

class LocationLoaded extends GateReportState {
  const LocationLoaded(this.latLng);

  final LatLng latLng;

  @override
  List<Object> get props => [latLng];
}
