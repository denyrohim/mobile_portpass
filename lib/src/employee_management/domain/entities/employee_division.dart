import 'package:equatable/equatable.dart';

class EmployeeDivision extends Equatable {
  final int id;
  final String name;

  const EmployeeDivision({
    required this.id,
    required this.name,
  });

  const EmployeeDivision.empty()
      : id = 0,
        name = '';

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  @override
  String toString() {
    return 'EmployeeDivision{id: $id, name: $name}';
  }
}
