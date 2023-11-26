import 'package:dio/dio.dart';
import 'package:port_pass_app/core/enums/update_user_action.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/headers.dart';
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

  Future<LocalUserModel> updateUser({
    required UpdateUserAction action,
    required LocalUserModel userData,
  });
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
        options: Options(
          headers: ApiHeaders.getHeaders().headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      var user = result.data['data']['user'] as DataMap?;
      final role = result.data['data']['role'] as String?;
      user?.addEntries([MapEntry('role', role)]);

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
        options: Options(
          headers: ApiHeaders.getHeaders(token: token).headers,
        ),
      );

      if (result.statusCode != 200) {
        throw ServerException(
          message: result.data['message'] as String? ?? "Error Occurred",
          statusCode: result.statusCode,
        );
      }

      var user = result.data['data']['user'] as DataMap?;
      final role = result.data['data']['role'] as String?;
      user?.addEntries([MapEntry('role', role)]);

      if (user == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }

      // await _sharedPreferences.remove(
      //   kToken,
      // );

      return LocalUserModel.fromMap(user);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LocalUserModel> updateUser({
    required UpdateUserAction action,
    required LocalUserModel userData,
  }) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final data = <String, dynamic>{};
      switch (action) {
        case UpdateUserAction.name:
          data["name"] = userData.name;
          break;
        case UpdateUserAction.email:
          data["email"] = userData.email;
          break;
        case UpdateUserAction.profileImg:
          data["profile_pic"] = MultipartFile.fromFile(userData.profileImg!,
              filename: userData.profileImg!.split('/').last);
          break;
      }
      final result = await _dio.put(
        _api.auth.profile,
        data: data,
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
            isImageRequest: true,
          ).headers,
        ),
      );
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
}
