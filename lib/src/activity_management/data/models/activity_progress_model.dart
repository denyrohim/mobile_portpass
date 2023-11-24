import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_progress.dart';

class ActivityProgressModel extends ActivityProgress {
  const ActivityProgressModel({
    required super.name,
    required super.date,
    required super.time,
  });
  const ActivityProgressModel.empty()
      : this(
          name: '',
          date: '',
          time: '',
        );

  ActivityProgressModel copyWith({
    String? name,
    String? date,
    String? time,
  }) {
    return ActivityProgressModel(
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  ActivityProgressModel.fromMap(DataMap map)
      : super(
          name: map['name'] as String,
          date: map['date'] as String,
          time: map['time'] as String,
        );

  DataMap toMap() {
    return {};
  }
}
