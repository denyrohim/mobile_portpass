import 'package:port_pass_app/core/services/configuration.dart';

class API {
  static const signIn = "${Configuratin.baseURL}/auth/sign-in";
  static const signInWithCredential =
      "${Configuratin.baseURL}/auth/sign-in-with-credential";
}
