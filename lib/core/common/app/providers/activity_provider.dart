import 'dart:io';

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

  List<Item> _itemsEditActivity = [];

  List<Item> get itemsEditActivity => _itemsEditActivity;

  void initItemsEditActivity(List<Item> items) {
    if (_itemsEditActivity != items) {
      _itemsEditActivity = List.from(
        items.map(
          (item) => Item(
            imagePath: item.imagePath,
            image: item.image,
            name: item.name,
            amount: item.amount,
            unit: item.unit,
          ),
        ),
      );
    }
    Future.delayed(Duration.zero, notifyListeners);
  }

  void resetItemsEditActivity() {
    _itemsEditActivity = [];
    Future.delayed(Duration.zero, notifyListeners);
  }

  void updateImageIteEditActivity(File image, int index) {
    _itemsEditActivity = List.from(
      _itemsEditActivity.map(
        (item) {
          if (_itemsEditActivity.indexOf(item) == index) {
            return Item(
              imagePath: image.path,
              image: image,
              name: item.name,
              amount: item.amount,
              unit: item.unit,
            );
          } else {
            return item;
          }
        },
      ),
    );
    Future.delayed(Duration.zero, notifyListeners);
  }

  List<Item> _itemsAddActivity = [];

  List<Item> get itemsAddActivity => _itemsAddActivity;

  void initItemsAddActivity(List<Item> items) {
    if (_itemsAddActivity != items) {
      _itemsAddActivity = List.from(
        items.map(
          (item) => Item(
            imagePath: item.imagePath,
            image: item.image,
            name: item.name,
            amount: item.amount,
            unit: item.unit,
          ),
        ),
      );
    }
    Future.delayed(Duration.zero, notifyListeners);
  }

  void resetItemsAddActivity() {
    _itemsAddActivity = [];
    Future.delayed(Duration.zero, notifyListeners);
  }

  void updateImageItemAddActivity(File image, int index) {
    _itemsAddActivity = List.from(
      _itemsAddActivity.map(
        (item) {
          if (_itemsAddActivity.indexOf(item) == index) {
            return Item(
              imagePath: image.path,
              image: image,
              name: item.name,
              amount: item.amount,
              unit: item.unit,
            );
          } else {
            return item;
          }
        },
      ),
    );
    Future.delayed(Duration.zero, notifyListeners);
  }
}
