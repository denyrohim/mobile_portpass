import 'package:flutter/cupertino.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

class EmployeesProvider extends ChangeNotifier {
  List<Employee>? _employees;

  List<Employee>? get employees => _employees;

  void initEmployees(List<Employee> employees) {
    if (_employees != employees) _employees = employees;
  }

  set user(List<Employee>? employees) {
    if (_employees != employees) {
      _employees = employees;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  bool _isShowChecked = false;

  bool get isShowChecked => _isShowChecked;

  void setShowChecked(bool value) {
    _isShowChecked = value;
    notifyListeners();
  }

  int get countEmployeeChecked {
    int count = 0;
    for (var i = 0; i < _employees!.length; i++) {
      if (_employees![i].isChecked) {
        count++;
      }
    }
    return count;
  }
}
