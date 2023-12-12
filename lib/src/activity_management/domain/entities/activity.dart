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
  });

  Activity.empty()
      : this(
          id: 0,
          name: 'Testing',
          shipName: 'Testing',
          type: 'Testing',
          date: '29/06/2021',
          time: '09:00',
          items: List.generate(5, (index) => const Item.empty()),
          status: 'Diterima',
          activityProgress:
              List.generate(5, (index) => const ActivityProgress.empty()),
          qrCode: '1234567890',
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
      ];
}
