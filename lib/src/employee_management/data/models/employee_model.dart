import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String dateOfBirth,
    required int employeeDivisionId,
    required String employeeType,
    required String nik,
    required String cardStart,
    String? cardStop,
    required String cardNumber,
    String? photo,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          dateOfBirth: dateOfBirth,
          employeeDivisionId: employeeDivisionId,
          employeeType: employeeType,
          nik: nik,
          cardStart: cardStart,
          cardStop: cardStop,
          cardNumber: cardNumber,
          photo: photo,
        );

  const EmployeeModel.empty()
      : this(
          id: 0,
          name: '',
          email: '',
          phone: '',
          dateOfBirth: '',
          employeeDivisionId: 0,
          employeeType: '',
          nik: '',
          cardStart: '',
          cardStop: '',
          cardNumber: '',
          photo: '',
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
    };
  }
}
