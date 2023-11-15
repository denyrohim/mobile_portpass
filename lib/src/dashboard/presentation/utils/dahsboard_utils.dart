import 'package:port_pass_app/src/auth/data/models/user_model.dart';

class DashboardUtils {
  const DashboardUtils._();

  // from Rest API
  static Stream<LocalUserModel> get userDataStream => Stream.value(
        const LocalUserModel(
          id: -99,
          email: 'email',
          name: 'name',
          role: 'role',
          profileImg: 'profile_img',
        ),
      );
}
