import 'package:equatable/equatable.dart';

class ActivityProgress extends Equatable {
  final String name;
  final String date;
  final String time;
  final String status;

  const ActivityProgress({
    required this.name,
    required this.date,
    required this.time,
    required this.status,
  });

  @override
  List<Object?> get props => [name, date, time, status];
}
