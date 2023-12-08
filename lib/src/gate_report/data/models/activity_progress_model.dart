import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity_progress.dart';

class ActivityProgressModel extends ActivityProgress {
  const ActivityProgressModel({
    required super.name,
    required super.date,
    required super.time,
    required super.status,
  });
  const ActivityProgressModel.empty()
      : this(
          name: '',
          date: '',
          time: '',
          status: '',
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
      status: status,
    );
  }

  ActivityProgressModel.fromMap(DataMap map)
      : super(
          name: map['name'] as String,
          date: map['date'] as String,
          time: map['time'] as String,
          status: map['status'] as String,
        );

  DataMap toMap() {
    return {};
  }
}
