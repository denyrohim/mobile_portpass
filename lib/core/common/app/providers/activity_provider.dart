import 'package:flutter/cupertino.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity>? _activities;

  List<Activity>? get activities => _activities;

  void initActivities(List<Activity> activities) {
    if (_activities != activities) {
      _activities = activities;
    }
    notifyListeners();
  }

  set activities(List<Activity>? activities) {
    if (_activities != activities) {
      _activities = activities;
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
    for (var i = 0; i < _activities!.length; i++) {
      if (_activities![i].isChecked) {
        count++;
      }
    }
    return count;
  }

  String searchText = '';

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  List<Activity> get filteredActivity {
    if (searchText.isEmpty) {
      return _activities ?? [];
    } else {
      return _activities!
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  List<int> get idCheckedEmployees {
    List<int> idCheckedEmployees = [];
    for (var i = 0; i < _activities!.length; i++) {
      if (_activities![i].isChecked) {
        idCheckedEmployees.add(_activities![i].id);
      }
    }
    return idCheckedEmployees;
  }

  List<Item>? _items;

  List<Item>? get items => _items;

  void initItems(List<Item> items) {
    if (_items != items) {
      _items = items;
    }
    notifyListeners();
  }

  set items(List<Item>? items) {
    if (_items != items) {
      _items = items;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  void resetItems() {
    _items = [];
    notifyListeners();
  }
}
