import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.dateOfBirth,
    required super.employeeDivisionId,
    required super.employeeType,
    required super.nik,
    required super.cardStart,
    super.cardStop,
    required super.cardNumber,
    super.photo,
    required super.isChecked,
  });

  const EmployeeModel.empty()
      : this(
          id: 0,
          name: 'Testing',
          email: '',
          phone: '',
          dateOfBirth: '',
          employeeDivisionId: 0,
          employeeType: 'Organik',
          nik: '',
          cardStart: '',
          cardStop: '',
          cardNumber: '',
          photo: null,
          isChecked: false,
        );

  EmployeeModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? dateOfBirth,
    int? employeeDivisionId,
    String? employeeType,
    String? nik,
    String? cardStart,
    String? cardStop,
    String? cardNumber,
    String? photo,
    bool? isChecked,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      employeeDivisionId: employeeDivisionId ?? this.employeeDivisionId,
      employeeType: employeeType ?? this.employeeType,
      nik: nik ?? this.nik,
      cardStart: cardStart ?? this.cardStart,
      cardStop: cardStop ?? this.cardStop,
      cardNumber: cardNumber ?? this.cardNumber,
      photo: photo ?? this.photo,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  EmployeeModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          name: map['name'] as String,
          email: map['email'] as String,
          phone: map['phone'] as String,
          dateOfBirth: map['date_of_birth'] as String,
          employeeDivisionId: map['bagian_id'] as int,
          employeeType: map['jenis_karyawan'] as String,
          nik: map['nik'] as String,
          cardStart: map['card_start'] as String,
          cardStop: map['card_stop'] as String?,
          cardNumber: map['card_number'] as String,
          photo: map['photo'] as String?,
          isChecked: map['is_checked'] as bool? ?? false,
        );

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'bagian_id': employeeDivisionId,
      'jenis_karyawan': employeeType,
      'nik': nik,
      'card_start': cardStart,
      'card_stop': cardStop,
      'card_number': cardNumber,
      'photo': photo,
      'is_checked': isChecked,
    };
  }
}
