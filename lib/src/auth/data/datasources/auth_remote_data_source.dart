import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });
  Future<LocalUserModel> signInWithCredential({
    required String token,
  });

  // Future<void> updateUser({
  //   required UpdateUserAction action,
  //   dynamic userData,
  // });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('result: $result');
      final user = result.user;
      if (user == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      await _setUserData(user, email);

      userData = await _getUserData(user.uid);

      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? "Error Occurred", statusCode: e.code);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LocalUserModel> signInWithCredential({required String token}) {
    // TODO: implement signInWithCredential
    throw UnimplementedError();
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

  Future<DocumentSnapshot<DataMap>> _getUserData(String id) async {
    return _cloudStoreClient.collection('users').doc(id).get();
  }

  Future<void> _setUserData(User user, String displayName) async {
    await _cloudStoreClient
        .collection('users')
        .doc(user.uid)
        .set(LocalUserModel(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? displayName,
          role: 'user',
        ).toMap());
  }

  // Future<void> _updateUserDate(DataMap data) async {
  //   await _cloudStoreClient
  //       .collection('users')
  //       .doc(_authClient.currentUser?.uid)
  //       .update(data);
  // }
}
