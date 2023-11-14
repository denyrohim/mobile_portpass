import 'package:dio/dio.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/data/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });
  Future<LocalUserModel> signInWithCredential();

  // Future<void> updateUser({
  //   required UpdateUserAction action,
  //   dynamic userData,
  // });
}

const kToken = 'token';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required Dio dio,
    required API api,
  })  : _dio = dio,
        _api = api,
        _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;
  final Dio _dio;
  final API _api;

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dio.post(
        _api.auth.signIn,
        data: {'email': email, 'password': password},
      );
      final user = result.data['data']['user'] as DataMap?;
      if (user == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      await _sharedPreferences.setString(
        kToken,
        result.data['data']['token'] as String,
      );

      return LocalUserModel.fromMap(user);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LocalUserModel> signInWithCredential() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }
      final result = await _dio.post(
        _api.auth.signInWithCredential,
        data: {'token': token},
      );

      if (result.statusCode != 200) {
        throw ServerException(
          message: result.data['message'] as String? ?? "Error Occurred",
          statusCode: result.statusCode,
        );
      }

      final user = result.data['data']['user'] as DataMap?;

      if (user == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      return LocalUserModel.fromMap(user);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  // @override
  // Future<void> updateUser({
  //   required UpdateUserAction action,
  //   userData,
  // }) async {
  //   try {
  //     switch (action) {
  //       case UpdateUserAction.email:
  //         await _authClient.currentUser?.updateEmail(userData as String);
  //         await _updateUserDate({'email': userData});
  //         await _updateUserDate({'username': userData});
  //         break;
  //       case UpdateUserAction.name:
  //         await _authClient.currentUser?.updateDisplayName(userData as String);
  //         await _updateUserDate({'name': userData});
  //         break;
  //       case UpdateUserAction.profilePic:
  //         final ref = _dbClient
  //             .ref()
  //             .child('profile_pics/${_authClient.currentUser?.uid}');
  //         await ref.putFile(userData as File);
  //         final url = await ref.getDownloadURL();
  //         await _authClient.currentUser?.updatePhotoURL(url);
  //         await _updateUserDate({'profilePic': url});
  //         break;
  //       case UpdateUserAction.password:
  //         if (_authClient.currentUser?.email == null) {
  //           throw const ServerException(
  //             message: "User doesn't exist",
  //             statusCode: 403,
  //           );
  //         }
  //         final newData = jsonDecode(userData as String) as DataMap;
  //         await _authClient.currentUser?.reauthenticateWithCredential(
  //           EmailAuthProvider.credential(
  //             email: _authClient.currentUser!.email!,
  //             password: newData['oldPassword'] as String,
  //           ),
  //         );
  //         await _authClient.currentUser?.updatePassword(
  //           newData['newPassword'] as String,
  //         );
  //         break;
  //       case UpdateUserAction.username:
  //         await _authClient.currentUser?.updateEmail(userData as String);
  //         await _updateUserDate({'email': userData});
  //         await _updateUserDate({'username': userData});
  //         break;
  //     }
  //   } on FirebaseException catch (e) {
  //     throw ServerException(
  //         message: e.message ?? "Error Occurred", statusCode: e.code);
  //   } catch (e, s) {
  //     debugPrintStack(stackTrace: s);
  //     throw ServerException(message: e.toString(), statusCode: 505);
  //   }
  // }

  // Future<DocumentSnapshot<DataMap>> _getUserData(String id) async {
  //   return _cloudStoreClient.collection('users').doc(id).get();
  // }

  // Future<void> _setUserData(User user, String displayName) async {
  //   await _cloudStoreClient
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(LocalUserModel(
  //         id: user.uid,
  //         email: user.email ?? '',
  //         name: user.displayName ?? displayName,
  //         role: 'user',
  //       ).toMap());
  // }

  // Future<void> _updateUserDate(DataMap data) async {
  //   await _cloudStoreClient
  //       .collection('users')
  //       .doc(_authClient.currentUser?.uid)
  //       .update(data);
  // }
}
