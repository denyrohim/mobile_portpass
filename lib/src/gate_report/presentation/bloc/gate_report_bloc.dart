import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';
import 'package:port_pass_app/src/gate_report/domain/usecases/add_documentation.dart';
import 'package:port_pass_app/src/gate_report/domain/usecases/add_report.dart';
import 'package:port_pass_app/src/gate_report/domain/usecases/add_urgent_letter.dart';
import 'package:port_pass_app/src/gate_report/domain/usecases/get_activity.dart';
import 'package:port_pass_app/src/gate_report/domain/usecases/get_location.dart';
import 'package:port_pass_app/src/gate_report/domain/usecases/scan_qr_activity.dart';

part 'gate_report_event.dart';
part 'gate_report_state.dart';

class GateReportBloc extends Bloc<GateReportEvent, GateReportState> {
  GateReportBloc({
    required AddDocumentation addDocumentation,
    required ScanQRActivity scanQRActivity,
    required GetLocation getLocation,
    required AddReport addReport,
    required AddUrgentLetter addUrgentLetter,
    required GetActivity getActivity,
  })  : _addDocumentation = addDocumentation,
        _scanQRActivity = scanQRActivity,
        _getLocation = getLocation,
        _addReport = addReport,
        _addUrgentLetter = addUrgentLetter,
        _getActivity = getActivity,
        super(const GateReportInitial()) {
    on<GateReportEvent>((event, emit) {
      emit(const GateReportLoading());
    });
    on<AddDocumentationEvent>(_addDocumentationHandler);
    on<ScanQrActivityEvent>(_scanQrActivityHandler);
    on<GetLocationEvent>(_getLocationHandler);
    on<AddReportEvent>(_addReportHandler);
    on<AddUrgentLetterEvent>(_addUrgentLetterHandler);
    on<GetActivityEvent>(_getActivityHandler);
  }

  final AddDocumentation _addDocumentation;
  final ScanQRActivity _scanQRActivity;
  final GetLocation _getLocation;
  final AddReport _addReport;
  final AddUrgentLetter _addUrgentLetter;
  final GetActivity _getActivity;

  Future<void> _addDocumentationHandler(
    AddDocumentationEvent event,
    Emitter<GateReportState> emit,
  ) async {
    final result = await _addDocumentation();
    result.fold(
      (failure) => emit(GateReportError(failure.errorMessage)),
      (photo) => emit(DocumentationAdded(photo)),
    );
  }

  Future<void> _scanQrActivityHandler(
    ScanQrActivityEvent event,
    Emitter<GateReportState> emit,
  ) async {
    final result = await _scanQRActivity(
      event.barcodes,
    );
    result.fold(
      (failure) => emit(ScanFailed(failure.errorMessage)),
      (result) => emit(ScanSuccess(result)),
    );
  }

  Future<void> _getLocationHandler(
    GetLocationEvent event,
    Emitter<GateReportState> emit,
  ) async {
    final result = await _getLocation(GetLocationParams(
      longitude: event.longitude,
      latitude: event.latitude,
    ));
    result.fold(
      (failure) => emit(GateReportError(failure.errorMessage)),
      (insideLocation) => emit(LocationLoaded(insideLocation)),
    );
  }

  Future<void> _addReportHandler(
    AddReportEvent event,
    Emitter<GateReportState> emit,
  ) async {
    final result = await _addReport(AddReportParams(
      activityId: event.activityId,
      reportData: event.reportData,
    ));
    result.fold(
      (failure) => emit(GateReportError(failure.errorMessage)),
      (activity) => emit(ReportAdded(activity)),
    );
  }

  Future<void> _addUrgentLetterHandler(
    AddUrgentLetterEvent event,
    Emitter<GateReportState> emit,
  ) async {
    final result = await _addUrgentLetter();
    result.fold(
      (failure) => emit(GateReportError(failure.errorMessage)),
      (file) => emit(UrgentLetterAdded(file)),
    );
  }

  Future<void> _getActivityHandler(
    GetActivityEvent event,
    Emitter<GateReportState> emit,
  ) async {
    final result = await _getActivity(
      event.activityId,
    );
    result.fold(
      (failure) => emit(GateReportError(failure.errorMessage)),
      (activity) => emit(ActivityLoaded(activity)),
    );
  }
}
