import 'package:equatable/equatable.dart';

class ActivityRoute extends Equatable {
  final int id;
  final String name;

  const ActivityRoute({
    required this.id,
    required this.name,
  });

  const ActivityRoute.empty()
      : this(
          id: 0,
          name: '',
        );

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
