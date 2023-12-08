import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gate_report_event.dart';
part 'gate_report_state.dart';

class GateReportBloc extends Bloc<GateReportEvent, GateReportState> {
  GateReportBloc() : super(GateReportInitial()) {
    on<GateReportEvent>((event, emit) {});
  }
}
