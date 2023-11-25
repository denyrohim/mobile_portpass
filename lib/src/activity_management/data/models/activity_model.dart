import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/data/models/activity_progress_model.dart';
import 'package:port_pass_app/src/activity_management/data/models/item_model.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required super.name,
    required super.shipName,
    required super.type,
    required super.date,
    required super.time,
    required super.items,
    required super.status,
    required super.activityProgress,
    required super.qrCode,
  });

  ActivityModel.empty()
      : this(
          name: '',
          shipName: '',
          type: '',
          date: '',
          time: '',
          items: [],
          status: '',
          activityProgress: [],
          qrCode: '',
        );

  ActivityModel copyWith({
    String? name,
    String? shipName,
    String? type,
    String? date,
    String? time,
    List<ItemModel>? items,
    String? status,
    List<ActivityProgressModel>? activityProgress,
    String? qrCode,
  }) {
    return ActivityModel(
      name: name ?? this.name,
      shipName: shipName ?? this.shipName,
      type: type ?? this.type,
      date: date ?? this.date,
      time: time ?? this.time,
      items: items ?? this.items,
      status: status ?? this.status,
      activityProgress: activityProgress ?? this.activityProgress,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  ActivityModel.fromMap(DataMap map)
      : super(
          name: map['name'] as String,
          shipName: map['ship_name'] as String,
          type: map['type'] as String,
          date: map['date'] as String,
          time: map['time'] as String,
          items: (map['items'] as List<DataMap>)
              .map((e) => ItemModel.fromMap(e))
              .toList(),
          status: map['status'] as String,
          activityProgress: (map['activity_progress'] as List<DataMap>)
              .map((e) => ActivityProgressModel.fromMap(e))
              .toList(),
          qrCode: map['qr_code'] as String,
        );

  DataMap toMap() {
    return {
      'name': name,
      'ship_name': shipName,
      'type': type,
      'date': date,
      'time': time,
      'items': items.map((e) => (e as ItemModel).toMap()).toList(),
      'status': status,
      'activity_progress': activityProgress
          .map((e) => (e as ActivityProgressModel).toMap())
          .toList(),
      'qr_code': qrCode,
    };
  }
}