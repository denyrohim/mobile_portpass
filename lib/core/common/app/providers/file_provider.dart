import 'dart:io';
import 'package:flutter/cupertino.dart';

class FileProvider extends ChangeNotifier {
  File? _fileEditEmployee;
  String? _filePathEditEmployee;

  File? get fileEditEmployee => _fileEditEmployee;
  String? get filePathEditEmployee => _filePathEditEmployee;

  void initFileEditEmployee(File fileEditEmployee) {
    if (_fileEditEmployee != fileEditEmployee) {
      _fileEditEmployee = fileEditEmployee;
      _filePathEditEmployee = fileEditEmployee.path;
    }
  }

  void initFilePathEditEmployee(String filePathEditEmployee) {
    if (_filePathEditEmployee != filePathEditEmployee) {
      _filePathEditEmployee = filePathEditEmployee;
    }
  }

  // reset
  void resetEditEmployee() {
    _fileEditEmployee = null;
    _filePathEditEmployee = null;
  }

  File? _fileAddEmployee;
  String? _filePathAddEmployee;

  File? get fileAddEmployee => _fileAddEmployee;
  String? get filePathAddEmployee => _filePathAddEmployee;

  void initFileAddEmployee(File fileAddEmployee) {
    if (_fileAddEmployee != fileAddEmployee) {
      _fileAddEmployee = fileAddEmployee;
      _filePathAddEmployee = fileAddEmployee.path;
    }
  }

  void initFilePathAddEmployee(String filePathAddEmployee) {
    if (_filePathAddEmployee != filePathAddEmployee) {
      _filePathAddEmployee = filePathAddEmployee;
    }
  }

  // reset
  void resetAddEmployee() {
    _fileAddEmployee = null;
    _filePathAddEmployee = null;
  }

  File? _fileEditUser;
  String? _filePathEditUser;

  File? get fileEditUser => _fileEditUser;
  String? get filePathEditUser => _filePathEditUser;

  void initFileEditUser(File fileEditUser) {
    if (_fileEditUser != fileEditUser) {
      _fileEditUser = fileEditUser;
      _filePathEditUser = fileEditUser.path;
    }
  }

  void initFilePathEditUser(String filePathEditUser) {
    if (_filePathEditUser != filePathEditUser) {
      _filePathEditUser = filePathEditUser;
    }
  }

  void resetEditUser() {
    _fileEditUser = null;
    _filePathEditUser = null;
  }
}
