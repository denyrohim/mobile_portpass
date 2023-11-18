import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_type.dart';

class EmployeeTypeModel extends EmployeeType {
  const EmployeeTypeModel({
    required int id,
    required String name,
  }) : super(id: id, name: name);

  const EmployeeTypeModel.empty()
      : this(
          id: 0,
          name: 'TypeNameTesting',
        );

  EmployeeTypeModel copyWith({
    int? id,
    String? name,
  }) {
    return EmployeeTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  EmployeeTypeModel.fromMap(DataMap map)
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
