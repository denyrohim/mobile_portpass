import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_progress.dart';

class ActivityProgressModel extends ActivityProgress {
  const ActivityProgressModel({
    required super.id,
    required super.activityId,
    required super.name,
    required super.urgentLetter,
    required super.documentation,
    required super.dateTime,
  });
  ActivityProgressModel.empty()
      : this(
          id: 0,
          activityId: 0,
          name: '',
          urgentLetter: null,
          documentation: null,
          dateTime: DateTime.now(),
        );

  ActivityProgressModel copyWith({
    int? id,
    int? activityId,
    String? name,
    String? urgentLetter,
    String? documentation,
    DateTime? dateTime,
  }) {
    return ActivityProgressModel(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      name: name ?? this.name,
      urgentLetter: urgentLetter ?? this.urgentLetter,
      documentation: documentation ?? this.documentation,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  ActivityProgressModel.fromMap(DataMap map)
      : super(
            id: map['id'] as int,
            activityId: map['activity_id'] as int,
            name: map['name'] as String,
            urgentLetter: map['file'] as String?,
            documentation: map['documentation'] as String?,
            dateTime: DateTime.parse(map['created_at']));

  DataMap toMap() {
    return {
      'id': id,
      'activity_id': activityId,
      'name': name,
      'file': urgentLetter,
      'documentation': documentation,
      'created_at': dateTime
    };
  }
}
