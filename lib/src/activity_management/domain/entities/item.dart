import 'dart:io';

import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String? imagePath;
  final File? image;
  final String name;
  final int amount;
  final String unit;

  const Item(
      {required this.imagePath,
      required this.image,
      required this.name,
      required this.amount,
      required this.unit});

  const Item.empty()
      : this(imagePath: null, image: null, name: '', amount: 0, unit: '');

  @override
  List<Object?> get props => [imagePath, image, name, amount, unit];
}
