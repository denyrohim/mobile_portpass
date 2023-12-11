import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.image,
    required super.name,
    required super.amount,
    required super.unit
  });

  const ItemModel.empty()
      : this(
          image: '',
          name: '',
          amount: 0,
          unit: ''
        );

  ItemModel copyWith({
    String? image,
    String? name,
    int? amount,
    String? unit
  }) {
    return ItemModel(
      image: image ?? this.image,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit
    );
  }

  ItemModel.fromMap(DataMap map)
      : super(
          image: map['image'] as String,
          name: map['name'] as String,
          amount: map['weight'] as int,
          unit: map['unit'] as String
        );

  DataMap toMap() {
    return {
      'image': image,
      'name': name,
      'amount': amount,
      'unit': unit
    };
  }
}
