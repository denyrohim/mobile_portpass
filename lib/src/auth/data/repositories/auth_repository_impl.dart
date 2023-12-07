import 'package:port_pass_app/core/enums/update_user_action.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:port_pass_app/src/auth/data/models/user_model.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> signInWithCredential() async {
    try {
      final result = await _remoteDataSource.signInWithCredential();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> updateUser({
    required List<UpdateUserAction> actions,
    required LocalUser userData,
  }) async {
    try {
      final LocalUserModel user = LocalUserModel(
        id: userData.id,
        email: userData.email,
        name: userData.name,
        role: userData.role,
        profileImg: userData.profileImg,
      );
      final result = await _remoteDataSource.updateUser(
        actions: actions,
        userData: user,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<dynamic> addPhoto({required String type}) async {
    try {
      final result = await _remoteDataSource.addPhoto(type: type);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
