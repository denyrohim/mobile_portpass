import 'package:equatable/equatable.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_progress.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

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
  final String qrCode;
  final bool isChecked;

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
          qrCode: '',
          isChecked: false,
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
      ];
}
