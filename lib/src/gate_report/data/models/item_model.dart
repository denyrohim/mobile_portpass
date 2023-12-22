import 'dart:io';

import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel(
      {required super.id,
      required super.imagePath,
      required super.image,
      required super.name,
      required super.amount,
      required super.unit});

  const ItemModel.empty()
      : this(
          id: 0,
          imagePath: null,
          image: null,
          name: '',
          amount: 0,
          unit: '',
        );

  ItemModel copyWith({
    int? id,
    String? imagePath,
    File? image,
    String? name,
    int? amount,
    String? unit,
  }) {
    return ItemModel(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        image: image ?? this.image,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        unit: unit ?? this.unit);
  }

  ItemModel.fromMap(DataMap map)
      : super(
            id: int.parse("${map['id']}"),
            imagePath: map['image'],
            image: null,
            name: map['name'],
            amount: int.parse(map['amount']),
            unit: map['unit']);

  DataMap toMap() {
    return {
      'id': id.toString(),
      'image': image != null ? CoreUtils.fileToUriBase64(image) : imagePath,
      'name': name,
      'amount': amount.toString(),
      'unit': unit
    };
  }
}
