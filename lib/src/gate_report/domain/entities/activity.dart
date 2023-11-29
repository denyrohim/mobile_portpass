import 'package:equatable/equatable.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity_progres.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/item.dart';

class Activity extends Equatable {
  final String name;
  final String shipName;
  final String type;
  final String date;
  final String time;
  final List<Item> items;
  final String status;
  final List<ActivityProgress> activityProgress;
  final String qrCode;

  const Activity({
    required this.name,
    required this.shipName,
    required this.type,
    required this.date,
    required this.time,
    required this.items,
    required this.status,
    required this.activityProgress,
    required this.qrCode,
  });

  @override
  List<Object?> get props => [name, shipName, type, date, time];
}