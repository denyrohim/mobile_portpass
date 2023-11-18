import 'package:equatable/equatable.dart';

class EmployeeType extends Equatable {
  final int id;
  final String name;

  const EmployeeType({
    required this.id,
    required this.name,
  });

  const EmployeeType.empty()
      : id = 0,
        name = '';

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  @override
  String toString() {
    return 'EmployeeType{id: $id, name: $name}';
  }
}
