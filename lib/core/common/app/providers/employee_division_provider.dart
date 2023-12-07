import 'package:flutter/cupertino.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';

class EmployeeDivisionProvider extends ChangeNotifier {
  List<EmployeeDivision>? _employeeDivisions;

  List<EmployeeDivision>? get employeeDivisions => _employeeDivisions;

  void initEmployeeDivision(List<EmployeeDivision> employeeDivisions) {
    if (_employeeDivisions != employeeDivisions) {
      _employeeDivisions = employeeDivisions;
    }
  }
}
