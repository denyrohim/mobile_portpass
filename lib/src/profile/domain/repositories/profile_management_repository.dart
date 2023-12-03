
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/core/enums/update_user_action.dart';

abstract class ProfileManagementRepository {
  const ProfileManagementRepository();

  ResultFuture<LocalUser> updateUser({
    required List<UpdateUserAction> actions,
    required LocalUser user,
  });

  ResultFuture<dynamic> addPhoto({
    required String type,
  });

}