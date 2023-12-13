import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class FileProvider extends ChangeNotifier {
  File? _fileEditEmployee;
  String? _filePathEditEmployee;
  String? _base64EditEmployee;
  String? _uriEditEmployee;

  File? get fileEditEmployee => _fileEditEmployee;
  String? get filePathEditEmployee => _filePathEditEmployee;
  String? get base64EditEmployee => _base64EditEmployee;
  String? get uriEditEmployee => _uriEditEmployee;

  void initFileEditEmployee(File fileEditEmployee) {
    if (_fileEditEmployee != fileEditEmployee) {
      _fileEditEmployee = fileEditEmployee;
      _filePathEditEmployee = fileEditEmployee.path;
      _base64EditEmployee = base64Encode(fileEditEmployee.readAsBytesSync());
      _uriEditEmployee =
          "data:image/${fileEditEmployee.path.split('/').last.split('.').last};base64,${base64Encode(fileEditEmployee.readAsBytesSync())}";
    }
  }

  void initFilePathEditEmployee(String? filePathEditEmployee) {
    if (_filePathEditEmployee != filePathEditEmployee) {
      _filePathEditEmployee = filePathEditEmployee;
    }
  }

  // reset
  void resetEditEmployee() {
    _fileEditEmployee = null;
    _filePathEditEmployee = null;
    _base64EditEmployee = null;
    _uriEditEmployee = null;
  }

  File? _fileAddEmployee;
  String? _filePathAddEmployee;
  String? _base64AddEmployee;
  String? _uriAddEmployee;

  File? get fileAddEmployee => _fileAddEmployee;
  String? get filePathAddEmployee => _filePathAddEmployee;
  String? get base64AddEmployee => _base64AddEmployee;
  String? get uriAddEmployee => _uriAddEmployee;

  void initFileAddEmployee(File fileAddEmployee) {
    if (_fileAddEmployee != fileAddEmployee) {
      _fileAddEmployee = fileAddEmployee;
      _filePathAddEmployee = fileAddEmployee.path;
      _base64AddEmployee = base64Encode(fileAddEmployee.readAsBytesSync());
      _uriAddEmployee =
          "data:image/${fileAddEmployee.path.split('/').last.split('.').last};base64,${base64Encode(fileAddEmployee.readAsBytesSync())}";
    }
  }

  void initFilePathAddEmployee(String? filePathAddEmployee) {
    if (_filePathAddEmployee != filePathAddEmployee) {
      _filePathAddEmployee = filePathAddEmployee;
    }
  }

  // reset
  void resetAddEmployee() {
    _fileAddEmployee = null;
    _filePathAddEmployee = null;
    _base64AddEmployee = null;
    _uriAddEmployee = null;
  }

  File? _fileEditUser;
  String? _filePathEditUser;
  String? _base64EditUser;
  String? _uriEditUser;

  File? get fileEditUser => _fileEditUser;
  String? get filePathEditUser => _filePathEditUser;
  String? get base64EditUser => _base64EditUser;
  String? get uriEditUser => _uriEditUser;

  void initFileEditUser(File fileEditUser) {
    if (_fileEditUser != fileEditUser) {
      _fileEditUser = fileEditUser;
      _filePathEditUser = fileEditUser.path;
      _base64EditUser = base64Encode(fileEditUser.readAsBytesSync());
      _uriEditUser =
          "data:image/${fileEditUser.path.split('/').last.split('.').last};base64,${base64Encode(fileEditUser.readAsBytesSync())}";
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
    _base64EditUser = null;
    _uriEditUser = null;
  }

  File? _fileAddActivity;
  String? _filePathAddActivity;
  String? _base64AddActivity;
  String? _uriAddActivity;

  File? get fileAddActivity => _fileAddActivity;
  String? get filePathAddActivity => _filePathAddActivity;
  String? get base64AddActivity => _base64AddActivity;
  String? get uriAddActivity => _uriAddActivity;

  void initFileAddActivity(File fileAddActivity) {
    if (_fileAddActivity != fileAddActivity) {
      _fileAddActivity = fileAddActivity;
      _filePathAddActivity = fileAddActivity.path;
      _base64AddActivity = base64Encode(fileAddActivity.readAsBytesSync());
      _uriAddActivity =
          "data:image/${fileAddActivity.path.split('/').last.split('.').last};base64,${base64Encode(fileAddActivity.readAsBytesSync())}";
    }
  }

  void initFilePathAddActivity(String filePathAddActivity) {
    if (_filePathAddActivity != filePathAddActivity) {
      _filePathAddActivity = filePathAddActivity;
    }
  }

  void resetAddActivity() {
    _fileAddActivity = null;
    _filePathAddActivity = null;
    _base64AddActivity = null;
    _uriAddActivity = null;
  }

  File? _fileEditActivity;
  String? _filePathEditActivity;
  String? _base64EditActivity;
  String? _uriEditActivity;

  File? get fileEditActivity => _fileEditActivity;
  String? get filePathEditActivity => _filePathEditActivity;
  String? get base64EditActivity => _base64EditActivity;
  String? get uriEditActivity => _uriEditActivity;

  void initFileEditActivity(File fileEditActivity) {
    if (_fileEditActivity != fileEditActivity) {
      _fileEditActivity = fileEditActivity;
      _filePathEditActivity = fileEditActivity.path;
      _base64EditActivity = base64Encode(fileEditActivity.readAsBytesSync());
      _uriEditActivity =
          "data:image/${fileEditActivity.path.split('/').last.split('.').last};base64,${base64Encode(fileEditActivity.readAsBytesSync())}";
    }
  }

  void initFilePathEditActivity(String filePathEditActivity) {
    if (_filePathEditActivity != filePathEditActivity) {
      _filePathEditActivity = filePathEditActivity;
    }
  }

  void resetEditActivity() {
    _fileEditActivity = null;
    _filePathEditActivity = null;
    _base64EditActivity = null;
    _uriEditActivity = null;
  }

  List<File>? _fileAddItems;
  List<String>? _filePathAddItems;
  List<String>? _base64AddItems;
  List<String>? _uriAddItems;

  List<File>? get fileAddItem => _fileAddItems;
  List<String>? get filePathAddItem => _filePathAddItems;
  List<String>? get base64AddItem => _base64AddItems;
  List<String>? get uriAddItem => _uriAddItems;

  File? fileAddItemByIndex(int index) {
    if (index == -1) {
      return _fileAddItems!.last;
    }
    return _fileAddItems![index];
  }

  String? filePathAddItemByIndex(int index) {
    if (index == -1) {
      return _filePathAddItems!.last;
    }
    return _filePathAddItems![index];
  }

  String? base64AddItemByIndex(int index) {
    if (index == -1) {
      return _base64AddItems!.last;
    }
    return _base64AddItems![index];
  }

  String? uriAddItemByIndex(int index) {
    if (index == -1) {
      return _uriAddItems!.last;
    }
    return _uriAddItems![index];
  }

  void addFileAddItems(File fileAddItem, {int index = -1}) {
    if (_fileAddItems == null) {
      _fileAddItems = [];
      _filePathAddItems = [];
      _base64AddItems = [];
      _uriAddItems = [];
    }

    if (index == -1) {
      _fileAddItems!.add(fileAddItem);
      _filePathAddItems!.add(fileAddItem.path);
      _base64AddItems!.add(base64Encode(fileAddItem.readAsBytesSync()));
      _uriAddItems!.add(
          "data:image/${fileAddItem.path.split('/').last.split('.').last};base64,${base64Encode(fileAddItem.readAsBytesSync())}");
    } else {
      _fileAddItems![index] = fileAddItem;
      _filePathAddItems![index] = fileAddItem.path;
      _base64AddItems![index] = base64Encode(fileAddItem.readAsBytesSync());
      _uriAddItems![index] =
          "data:image/${fileAddItem.path.split('/').last.split('.').last};base64,${base64Encode(fileAddItem.readAsBytesSync())}";
    }
  }

  void changeLastFileAddItems(File fileAddItem) {
    _fileAddItems!.removeLast();
    _filePathAddItems!.removeLast();
    _base64AddItems!.removeLast();
    _uriAddItems!.removeLast();
    _fileAddItems!.add(fileAddItem);
    _filePathAddItems!.add(fileAddItem.path);
    _base64AddItems!.add(base64Encode(fileAddItem.readAsBytesSync()));
    _uriAddItems!.add(
        "data:image/${fileAddItem.path.split('/').last.split('.').last};base64,${base64Encode(fileAddItem.readAsBytesSync())}");
  }

  // reset
  void resetAddItems() {
    _fileAddItems = null;
    _filePathAddItems = null;
    _base64AddItems = null;
    _uriAddItems = null;
  }

  File? _fileEditItem;
  String? _filePathEditItem;
  String? _base64EditItem;
  String? _uriEditItem;

  File? get fileEditItem => _fileEditItem;
  String? get filePathEditItem => _filePathEditItem;
  String? get base64EditItem => _base64EditItem;
  String? get uriEditItem => _uriEditItem;

  void initFileEditItem(File fileEditItem) {
    if (_fileEditItem != fileEditItem) {
      _fileEditItem = fileEditItem;
      _filePathEditItem = fileEditItem.path;
      _base64EditItem = base64Encode(fileEditItem.readAsBytesSync());
      _uriEditItem =
          "data:image/${fileEditItem.path.split('/').last.split('.').last};base64,${base64Encode(fileEditItem.readAsBytesSync())}";
    }
  }

  void initFilePathEditItem(String? filePathEditItem) {
    if (_filePathEditItem != filePathEditItem) {
      _filePathEditItem = filePathEditItem;
    }
  }

  // reset
  void resetEditItem() {
    _fileEditItem = null;
    _filePathEditItem = null;
    _base64EditItem = null;
    _uriEditItem = null;
  }

  File? _fileAddReport;
  String? _filePathAddReport;
  String? _fileNameAddReport;
  double? _fileSizeAddReport;
  String? _fileUnitSizeAddReport;
  String? _base64AddReport;
  String? _uriAddReport;

  File? get fileAddReport => _fileAddReport;
  String? get filePathAddReport => _filePathAddReport;
  double? get fileSizeAddReport => _fileSizeAddReport;
  String? get fileUnitSizeAddReport => _fileUnitSizeAddReport;
  String? get fileNameAddReport => _fileNameAddReport;
  String? get base64AddReport => _base64AddReport;
  String? get uriAddReport => _uriAddReport;

  void initFileAddReport(File fileAddReport) {
    if (_fileAddReport != fileAddReport) {
      _fileAddReport = fileAddReport;
      _filePathAddReport = fileAddReport.path;
      _fileNameAddReport = fileAddReport.path.split('/').last;
      _fileSizeAddReport = fileAddReport.lengthSync() > 1000000
          ? fileAddReport.lengthSync() / 1000000
          : fileAddReport.lengthSync() > 1000
              ? fileAddReport.lengthSync() / 1000
              : fileAddReport.lengthSync() / 1;
      _fileUnitSizeAddReport = fileAddReport.lengthSync() > 1000000
          ? "MB"
          : fileAddReport.lengthSync() > 1000
              ? "KB"
              : "Bytes";
      _base64AddReport = base64Encode(fileAddReport.readAsBytesSync());
      _uriAddReport =
          "data:image/${fileAddReport.path.split('/').last.split('.').last};base64,${base64Encode(fileAddReport.readAsBytesSync())}";
    }
  }

  void initFilePathAddReport(String filePathAddReport) {
    if (_filePathAddReport != filePathAddReport) {
      _filePathAddReport = filePathAddReport;
    }
  }

  void resetFileAddReport() {
    _fileAddReport = null;
    _filePathAddReport = null;
    _fileNameAddReport = null;
    _fileSizeAddReport = null;
    _fileUnitSizeAddReport = null;
    _base64AddReport = null;
    _uriAddReport = null;
  }

  File? _documentationAddReport;
  String? _documentationPathAddReport;
  String? _documentationNameAddReport;
  double? _documentationSizeAddReport;
  String? _documentationUnitSizeAddReport;
  String? _documentationBase64AddReport;
  String? _documentationUriAddReport;

  File? get documentationAddReport => _documentationAddReport;
  String? get documentationPathAddReport => _documentationPathAddReport;
  String? get documentationNameAddReport => _documentationNameAddReport;
  double? get documentationSizeAddReport => _documentationSizeAddReport;
  String? get documentationUnitSizeAddReport => _documentationUnitSizeAddReport;
  String? get documentationBase64AddReport => _documentationBase64AddReport;
  String? get documentationUriAddReport => _documentationUriAddReport;

  void initDocumentationAddReport(File documentationAddReport) {
    if (_documentationAddReport != documentationAddReport) {
      _documentationAddReport = documentationAddReport;
      _documentationPathAddReport = documentationAddReport.path;
      _documentationNameAddReport = documentationAddReport.path.split('/').last;
      _documentationSizeAddReport =
          documentationAddReport.lengthSync() > 1000000
              ? documentationAddReport.lengthSync() / 1000000
              : documentationAddReport.lengthSync() > 1000
                  ? documentationAddReport.lengthSync() / 1000
                  : documentationAddReport.lengthSync() / 1;
      _documentationUnitSizeAddReport =
          documentationAddReport.lengthSync() > 1000000
              ? "MB"
              : documentationAddReport.lengthSync() > 1000
                  ? "KB"
                  : "Bytes";
      _documentationBase64AddReport =
          base64Encode(documentationAddReport.readAsBytesSync());
      _documentationUriAddReport =
          "data:image/${documentationAddReport.path.split('/').last.split('.').last};base64,${base64Encode(documentationAddReport.readAsBytesSync())}";
    }
  }

  void initDocumentationPathAddReport(String documentationPathAddReport) {
    if (_documentationPathAddReport != documentationPathAddReport) {
      _documentationPathAddReport = documentationPathAddReport;
    }
  }

  void resetDocumentationAddReport() {
    _documentationAddReport = null;
    _documentationPathAddReport = null;
    _documentationNameAddReport = null;
    _documentationSizeAddReport = null;
    _documentationBase64AddReport = null;
    _documentationUriAddReport = null;
  }
}
