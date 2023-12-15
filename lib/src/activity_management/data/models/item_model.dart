import 'dart:io';

import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel(
      {required super.imagePath,
      required super.image,
      required super.name,
      required super.amount,
      required super.unit});

  const ItemModel.empty()
      : this(imagePath: null, image: null, name: '', amount: 0, unit: '');

  ItemModel copyWith(
      {String? imagePath,
      File? image,
      String? name,
      int? amount,
      String? unit}) {
    return ItemModel(
        imagePath: imagePath ?? this.imagePath,
        image: image ?? this.image,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        unit: unit ?? this.unit);
  }

  ItemModel.fromMap(DataMap map)
      : super(
            imagePath: map['image'] as String,
            image: null,
            name: map['name'] as String,
            amount: map['amount'] as int,
            unit: map['unit'] as String);

  DataMap toMap() {
    return {
      'imagePath': imagePath,
      'image': image,
      'name': name,
      'amount': amount,
      'unit': unit
    };
  }
}
