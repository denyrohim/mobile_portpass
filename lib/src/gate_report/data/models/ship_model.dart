import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/ship.dart';

class ShipModel extends Ship {
  const ShipModel({
    required super.id,
    required super.name,
  });

  const ShipModel.empty()
      : this(
          id: 0,
          name: '',
        );

  ShipModel copyWith({
    int? id,
    String? name,
  }) {
    return ShipModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  ShipModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          name: map['name'] as String,
        );

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
