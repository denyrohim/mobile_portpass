part of 'gate_report_bloc.dart';

sealed class GateReportState extends Equatable {
  const GateReportState();
  
  @override
  List<Object> get props => [];
}

final class GateReportInitial extends GateReportState {}
