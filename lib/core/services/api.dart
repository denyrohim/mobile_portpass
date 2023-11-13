import 'package:port_pass_app/core/services/configuration.dart';

class API {
  final APIAuth auth;
  final APIEmployees employees;
  final APIAgent agent;
  final APIActivity activity;
  final APIItems items;

  API({String? id})
      : auth = APIAuth(id: id),
        employees = APIEmployees(id: id),
        agent = APIAgent(id: id),
        activity = APIActivity(id: id),
        items = APIItems(id: id);
}

class APIAuth {
  const APIAuth({this.id});

  final String? id;

  String get signIn => "${Configuratin.baseURL}/login";
  String get signInWithCredential =>
      "${Configuratin.baseURL}/login-with-credential";
  String get profile => "${Configuratin.baseURL}/profile";
}

class APIEmployees {
  const APIEmployees({this.id});
  final String? id;

  String get employees => "${Configuratin.baseURL}/employees";
  String get employeeDetail => "$employees/$id";
}

class APIAgent {
  const APIAgent({this.id});
  final String? id;

  String get activities => "${Configuratin.baseURL}/activities/ship-chandler";
  String get activityDetail => "$activities/$id";
}

class APIActivity {
  const APIActivity({this.id});
  final String? id;

  String get activities => "${Configuratin.baseURL}/activities/security";
  String get activityDetail => "$activities/$id";
  String get scanQRCode => "$activityDetail/scan-qr-code";
}

class APIItems {
  const APIItems({this.id});
  final String? id;

  String get items => "${Configuratin.baseURL}/goods";
  String get detailItem => "$items/$id";
}
