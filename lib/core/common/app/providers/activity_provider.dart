import 'package:flutter/cupertino.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity>? _activities;

  List<Activity>? get activities => _activities;

  void initActivity(List<Activity> activities) {
    if (_activities != activities) {
      _activities = activities;
    }
    notifyListeners();
  }

  set user(List<Activity>? activities) {
    if (_activities != activities) {
      _activities = activities;
      Future.delayed(Duration.zero, notifyListeners);
    }
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
}
