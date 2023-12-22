import 'package:equatable/equatable.dart';

class Ship extends Equatable {
  final int id;
  final String name;

  const Ship({
    required this.id,
    required this.name,
  });

  const Ship.empty()
      : this(
          id: 0,
          name: '',
        );

  @override
  List<Object?> get props => [id, name];
}
