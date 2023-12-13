import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String? image;
  final String name;
  final int amount;
  final String unit;

  const Item(
      {required this.image,
      required this.name,
      required this.amount,
      required this.unit});

  const Item.empty() : this(image: '', name: '', amount: 0, unit: '');

  @override
  List<Object?> get props => [image, name, amount, unit];
}
