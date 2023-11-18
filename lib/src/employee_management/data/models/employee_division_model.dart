import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';

class EmployeeDivisionModel extends EmployeeDivision {
  const EmployeeDivisionModel({
    required int id,
    required String name,
  }) : super(id: id, name: name);

  const EmployeeDivisionModel.empty()
      : this(
          id: 0,
          name: 'DisvisionNameTesting',
        );

  EmployeeDivisionModel copyWith({
    int? id,
    String? name,
  }) {
    return EmployeeDivisionModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  EmployeeDivisionModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          name: map['name'] as String,
        );

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
