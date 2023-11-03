import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<LocalUser> signInWithCredential();

  // ResultFuture<void> updateUser({
  //   required UpdateUserAction action,
  //   required dynamic userData,
  // });
}
