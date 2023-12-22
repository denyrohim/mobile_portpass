import 'dart:io';

import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/data/models/activity_progress_model.dart';
import 'package:port_pass_app/src/gate_report/data/models/item_model.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required super.id,
    required super.name,
    required super.shipName,
    required super.type,
    required super.date,
    required super.time,
    required super.items,
    required super.status,
    required super.activityProgress,
    required super.qrCode,
    super.isChecked = false,
    super.route,
  });

  ActivityModel.empty()
      : this(
          id: 0,
          name: '',
          shipName: '',
          type: '',
          date: '',
          time: '',
          items: [],
          status: '',
          activityProgress: [],
          qrCode: null,
          isChecked: false,
          route: null,
        );

  ActivityModel copyWith({
    int? id,
    String? name,
    String? shipName,
    String? type,
    String? date,
    String? time,
    List<ItemModel>? items,
    String? status,
    List<ActivityProgressModel>? activityProgress,
    File? qrCode,
    bool? isChecked,
    String? route,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shipName: shipName ?? this.shipName,
      type: type ?? this.type,
      date: date ?? this.date,
      time: time ?? this.time,
      items: items ?? this.items,
      status: status ?? this.status,
      activityProgress: activityProgress ?? this.activityProgress,
      qrCode: qrCode ?? this.qrCode,
      isChecked: isChecked ?? this.isChecked,
      route: route ?? this.route,
    );
  }

  ActivityModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          name: (map['title'] ?? "") as String,
          shipName: map['ship_id'] as String,
          type: map['jenis_pekerjaan'] as String,
          date: (map['start_date'] as String).split(' ')[0],
          time: (map['start_date'] as String).split(' ')[1],
          items: ((map['goods'] as List<dynamic>).isNotEmpty)
              ? (map['goods'] as List<dynamic>)
                  .map((e) => ItemModel.fromMap(e))
                  .toList()
              : [],
          status: map['status'] as String,
          activityProgress:
              ((map['activity_progress'] as List<dynamic>).isNotEmpty)
                  ? (map['activity_progress'] as List<dynamic>)
                      .map((e) => ActivityProgressModel.fromMap(e))
                      .toList()
                  : [],
          qrCode: map['qr_code'] as File?,
          isChecked: false,
          route: map['route'] as String?,
        );

  DataMap toMap() {
    return {
      'id': id,
      'code': name,
      'ship_id': shipName,
      'jenis_pekerjaan': type,
      'start_date': "$date $time",
      'goods': items
          .map(
            (e) => ItemModel(
              id: e.id,
              imagePath: e.imagePath,
              image: null,
              name: e.name,
              amount: e.amount,
              unit: e.unit,
            ).toMap(),
          )
          .toList(),
      'status': status,
      'activity_progress': activityProgress
          .map((e) => ActivityProgressModel(
                id: e.id,
                activityId: e.activityId,
                name: e.name,
                urgentLetter: e.urgentLetter,
                documentation: e.documentation,
                dateTime: e.dateTime,
              ).toMap())
          .toList(),
      'qr_code': qrCode,
      'isChecked': isChecked,
      'route': route,
    };
  }
}
