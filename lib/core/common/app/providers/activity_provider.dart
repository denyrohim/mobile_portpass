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

  int get countActivitiesChecked {
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

  List<int> get idCheckedActivities {
    List<int> idCheckedActivities = [];
    for (var i = 0; i < _activities!.length; i++) {
      if (_activities![i].isChecked) {
        idCheckedActivities.add(_activities![i].id);
      }
    }
    return idCheckedActivities;
  }

  List<Item>? _itemsAdd;

  List<Item>? get itemsAdd => _itemsAdd;

  void initItemsAdd(List<Item> itemsAdd) {
    if (_itemsAdd != itemsAdd) {
      _itemsAdd = itemsAdd;
    }
    notifyListeners();
  }

  set itemsAdd(List<Item>? itemsAdd) {
    if (_itemsAdd != itemsAdd) {
      _itemsAdd = itemsAdd;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  void resetItemsAdd() {
    _itemsAdd = [];
    notifyListeners();
  }

  List<Item>? _itemsEdit;

  List<Item>? get itemsEdit => _itemsEdit;

  void initItemsEdit(List<Item> itemsEdit) {
    if (_itemsEdit != itemsEdit) {
      _itemsEdit = itemsEdit;
    }
    notifyListeners();
  }

  set itemsEdit(List<Item>? itemsEdit) {
    if (_itemsEdit != itemsEdit) {
      _itemsEdit = itemsEdit;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  void resetItemsEdit() {
    _itemsEdit = [];
    notifyListeners();
  }
}
