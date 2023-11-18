import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String dateOfBirth;
  final int employeeDivisionId;
  final String employeeType;
  final String nik;
  final String cardStart;
  final String? cardStop;
  final String cardNumber;
  final String? photo;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.employeeDivisionId,
    required this.employeeType,
    required this.nik,
    required this.cardStart,
    this.cardStop,
    required this.cardNumber,
    this.photo,
  });

  const Employee.empty()
      : id = 0,
        name = '',
        email = '',
        phone = '',
        dateOfBirth = '',
        employeeDivisionId = 0,
        employeeType = '',
        nik = '',
        cardStart = '',
        cardStop = '',
        cardNumber = '',
        photo = '';

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        nik,
        cardNumber,
      ];

  @override
  String toString() {
    return 'Employee{id: $id, name: $name,'
        ' email: $email, phone: $phone,'
        ' dateOfBirth: $dateOfBirth, employeeDivisionId: $employeeDivisionId,'
        ' employeeType: $employeeType, nik: $nik,'
        ' cardStart: $cardStart,'
        ' cardStop: $cardStop,'
        ' cardNumber: $cardNumber, photo: $photo}';
  }
}
