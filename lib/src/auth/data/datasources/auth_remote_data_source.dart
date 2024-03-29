import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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
    required List<UpdateUserAction> actions,
    required LocalUserModel userData,
  });

  Future<void> signOut();

  Future<dynamic> addPhoto({
    required String type,
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
      if (result.statusCode == 401) {
        throw ServerException(
          message: "Email or Password is incorrect",
          statusCode: result.statusCode,
        );
      }
      if (result.statusCode != 200) {
        throw ServerException(
          message: result.data['message'] as String? ?? "Error Occurred",
          statusCode: result.statusCode,
        );
      }
      var user = result.data['data']['user'] as DataMap?;

      if (user == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      final photo = user['profile_img'] as String?;
      if (photo != null) {
        if (photo.split('/').first == "https:") {
          user['profile_img'] = null;
        } else {
          final photoPath = photo.split('/').last;

          user['profile_img'] = "${_api.baseUrl}/images/profile/$photoPath";
        }
      }

      user['location'] = user['checkPoint']['name'];
      user['latitude'] = double.parse(user['checkPoint']['latitude']);
      user['longitude'] = double.parse(user['checkPoint']['longitude']);

      await _sharedPreferences.setString(
        kToken,
        result.data['data']['token'] as String,
      );
      // const user = LocalUserModel.empty();

      return LocalUserModel.fromMap(user);
      // return user;
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
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (result.statusCode != 200) {
        throw ServerException(
          message: result.data['message'] as String? ?? "Error Occurred",
          statusCode: result.statusCode,
        );
      }

      var user = result.data['data']['user'] as DataMap?;

      if (user == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      final photo = user['profile_img'] as String?;
      if (photo != null) {
        if (photo.split('/').first == "https:") {
          user['profile_img'] = null;
        } else {
          final photoPath = photo.split('/').last;

          user['profile_img'] = "${_api.baseUrl}/images/profile/$photoPath";
        }
      }

      user['location'] = user['checkPoint']['name'];
      user['latitude'] = double.parse(user['checkPoint']['latitude']);
      user['longitude'] = double.parse(user['checkPoint']['longitude']);

      return LocalUserModel.fromMap(user);
      // const user = LocalUserModel.empty();
      // return user;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LocalUserModel> updateUser({
    required List<UpdateUserAction> actions,
    required LocalUserModel userData,
  }) async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      final data = <String, dynamic>{};
      for (final action in actions) {
        switch (action) {
          case UpdateUserAction.name:
            data["name"] = userData.name;
            break;
          case UpdateUserAction.email:
            data["email"] = userData.email;
            break;
          case UpdateUserAction.profileImg:
            data["profile_img"] = userData.profileImg;
            break;
        }
      }
      final result = await _dio.put(
        _api.auth.profile,
        data: data,
        options: Options(
          headers: ApiHeaders.getHeaders(
            token: token,
          ).headers,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      var user = result.data['data'] as DataMap?;
      if (user == null) {
        throw const ServerException(
            message: "Please try again later", statusCode: 505);
      }
      user['role'] = userData.role;
      final photo = user['profile_img'] as String?;
      if (photo != null) {
        if (photo.split('/').first == "https:") {
          user['profile_img'] = null;
        } else {
          final photoPath = photo.split('/').last;

          user['profile_img'] = "${_api.baseUrl}/images/profile/$photoPath";
        }
      }

      user['location'] = userData.location;
      user['latitude'] = userData.latitude;
      user['longitude'] = userData.longitude;

      return LocalUserModel.fromMap(user);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final token = _sharedPreferences.getString(kToken);

      if (token != null) {
        await _dio.get(
          _api.auth.logout,
          options: Options(
            headers: ApiHeaders.getHeaders(
              token: token,
            ).headers,
            validateStatus: (_) {
              return true;
            },
          ),
        );
      } else {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      await _sharedPreferences.remove(kToken);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<dynamic> addPhoto({required String type}) async {
    try {
      if (type != "remove") {
        final result = await ImagePicker().pickImage(
          source: (type == "camera") ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 150,
        );

        if (result == null) {
          throw ServerException(
              message: "$type can't be accessed", statusCode: 505);
        }
        final image = File(result.path);
        // debugPrint("imagePath: $imagePath");
        // final List<int> bytes = await result.readAsBytes();
        // final String base64 = base64Encode(bytes);
        return image;
      } else {
        return null;
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
