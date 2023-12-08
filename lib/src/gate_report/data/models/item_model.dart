import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.image,
    required super.name,
    required super.weight,
  });

  const ItemModel.empty()
      : this(
          image: '',
          name: '',
          weight: '',
        );

  ItemModel copyWith({
    String? image,
    String? name,
    String? weight,
  }) {
    return ItemModel(
      image: image ?? this.image,
      name: name ?? this.name,
      weight: weight ?? this.weight,
    );
  }

  ItemModel.fromMap(DataMap map)
      : super(
          image: map['image'] as String,
          name: map['name'] as String,
          weight: map['weight'] as String,
        );

  DataMap toMap() {
    return {
      'image': image,
      'name': name,
      'weight': weight,
    };
  }
}
