part of 'gate_report_bloc.dart';

abstract class GateReportEvent extends Equatable {
  const GateReportEvent();
}

class AddDocumentationEvent extends GateReportEvent {
  const AddDocumentationEvent();

  @override
  List<Object> get props => [];
}

class AddReportEvent extends GateReportEvent {
  const AddReportEvent({
    required this.activityId,
    required this.reportData,
  });

  final int activityId;
  final Report reportData;

  @override
  List<Object> get props => [activityId, reportData];
}

class AddUrgentLetterEvent extends GateReportEvent {
  const AddUrgentLetterEvent();

  @override
  List<Object> get props => [];
}

class GetActivityEvent extends GateReportEvent {
  const GetActivityEvent({
    required this.activityCode,
  });

  final String activityCode;

  @override
  List<Object> get props => [activityCode];
}

class GetLocationEvent extends GateReportEvent {
  const GetLocationEvent({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  List<Object> get props => [];
}

class ScanQrActivityEvent extends GateReportEvent {
  const ScanQrActivityEvent({
    required this.barcodes,
  });

  final List<Barcode> barcodes;

  @override
  List<Object> get props => [barcodes];
}
