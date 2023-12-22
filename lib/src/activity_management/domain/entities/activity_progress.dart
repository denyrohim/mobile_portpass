import 'package:equatable/equatable.dart';

class ActivityProgress extends Equatable {
  final int id;
  final int activityId;
  final String name;
  final String? urgentLetter;
  final String? documentation;
  final DateTime dateTime;

  const ActivityProgress({
    required this.id,
    required this.activityId,
    required this.name,
    required this.urgentLetter,
    required this.documentation,
    required this.dateTime,
  });

  ActivityProgress.empty()
      : this(
          id: 0,
          activityId: 0,
          name: '',
          urgentLetter: null,
          documentation: null,
          dateTime: DateTime.now(),
        );

  @override
  List<Object?> get props => [
        id,
        activityId,
        name,
        urgentLetter,
        documentation,
        dateTime,
      ];
}
