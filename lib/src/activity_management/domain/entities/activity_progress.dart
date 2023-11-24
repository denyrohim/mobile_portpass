import 'package:equatable/equatable.dart';

class ActivityProgress extends Equatable {
  final String name;
  final String date;
  final String time;

  const ActivityProgress({
    required this.name,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [name, date, time];
}
