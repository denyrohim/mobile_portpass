import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String image;
  final String name;
  final String weight;

  const Item({
    required this.image,
    required this.name,
    required this.weight,
  });

  const Item.empty()
      : this(
          image: '',
          name: 'Testing',
          weight: '15 Kg',
        );

  @override
  List<Object?> get props => [image, name, weight];
}
