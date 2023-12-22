import 'package:port_pass_app/core/utils/typedef.dart';

import '../../domain/entities/activity_route.dart';

class ActivityRouteModel extends ActivityRoute {
  const ActivityRouteModel({
    required super.id,
    required super.name,
  });
  const ActivityRouteModel.empty()
      : this(
          id: 0,
          name: '',
        );

  ActivityRouteModel copyWith({
    int? id,
    String? name,
  }) {
    return ActivityRouteModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  ActivityRouteModel.fromMap(DataMap map)
      : super(id: map['id'] as int, name: map['name'] as String);

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
