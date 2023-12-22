import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity_progress.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/item.dart';

class Activity extends Equatable {
  final int id;
  final String name;
  final String shipName;
  final String type;
  final String date;
  final String time;
  final List<Item> items;
  final String status;
  final List<ActivityProgress> activityProgress;
  final File? qrCode;
  final bool isChecked;
  final String? route;

  const Activity({
    required this.id,
    required this.name,
    required this.shipName,
    required this.type,
    required this.date,
    required this.time,
    required this.items,
    required this.status,
    required this.activityProgress,
    required this.qrCode,
    required this.isChecked,
    this.route,
  });

  Activity.empty()
      : this(
          id: 0,
          name: '',
          shipName: '',
          type: '',
          date: '',
          time: '',
          items: [],
          status: '',
          activityProgress: List<ActivityProgress>.empty(),
          qrCode: null,
          isChecked: false,
          route: null,
        );

  @override
  List<Object?> get props => [
        id,
        name,
        shipName,
        type,
        date,
        time,
        items,
        status,
        activityProgress,
        qrCode,
        isChecked,
        route
      ];
}
