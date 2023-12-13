import 'package:flutter/cupertino.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/location.dart';

class ReportProvider extends ChangeNotifier {
  Activity? _activity;
  Activity? get activity => _activity;

  void initActivity(Activity? activity) {
    if (_activity != activity) {
      _activity = activity;
    }
    notifyListeners();
  }

  void resetActivity() {
    _activity = null;
    notifyListeners();
  }

  Location? _location;
  Location? get location => _location;

  void initLocation(Location? location) {
    if (_location != location) {
      _location = location;
    }
    notifyListeners();
  }

  void resetLocation() {
    _location = null;
    notifyListeners();
  }

  int? _activityId;
  int? get activityId => _activityId;

  void initActivityId(int? activityId) {
    if (_activityId != activityId) {
      _activityId = activityId;
    }
    notifyListeners();
  }
}
