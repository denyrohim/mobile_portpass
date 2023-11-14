import 'package:dio/dio.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';

import 'package:port_pass_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:port_pass_app/src/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockDio extends Mock implements Dio {}

void main() {
  late SharedPreferences sharedPreferences;
  late Dio dio;
  late API api;
  late AuthRemoteDataSourceImpl dataSource;
  const tUser = LocalUserModel.empty();

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    dio = MockDio();
    api = API();
    dataSource = AuthRemoteDataSourceImpl(
      sharedPreferences: sharedPreferences,
      dio: dio,
      api: api,
    );
  });

  const tPassword = 'password';
  const tEmail = 'email@admin.com';
  const tToken = 'token';

  final tResponseFailed = Response(
    data: {
      'message': 'ServerException',
      'user': null,
    },
    statusCode: 500,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseSuccess = Response<dynamic>(
    data: {
      'message': 'Success',
      'data': {
        'user': tUser.toMap(),
        'token': 'token',
      },
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  const tServerException = ServerException(
    message: 'ServerException',
    statusCode: 500,
  );

  group(
    'signIn',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => tResponseSuccess);

        when(() => sharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);

        final result = await dataSource.signIn(
          email: tEmail,
          password: tPassword,
        );

        expect(result, equals(tUser));

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);

        verify(() => sharedPreferences.setString(kToken, 'token')).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });

      test(
        'should throw [ServerException] when user is null after signining in',
        () async {
          when(
            () => dio.post(
              any(),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async => tResponseFailed);

          final call = dataSource.signIn;
          expect(
            () => call(email: tEmail, password: tPassword),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.post(
              any(),
              data: any(named: 'data'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );

      test('should throw [ServerException] when endpoint is not found',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(tServerException);

        final call = dataSource.signIn;
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);
      });
    },
  );

  group(
    'signInWithCredential',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => tResponseSuccess);

        when(() => sharedPreferences.getString(any())).thenReturn(tToken);

        final result = await dataSource.signInWithCredential();

        expect(result, equals(tUser));

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);

        verify(() => sharedPreferences.getString(any())).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });

      test(
        'should throw [ServerException] when user is null after signining in',
        () async {
          when(
            () => dio.post(
              any(),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async => tResponseFailed);

          when(() => sharedPreferences.getString(any())).thenReturn(kToken);

          final call = dataSource.signInWithCredential;
          expect(
            () => call(),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.post(
              any(),
              data: any(named: 'data'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);

          verify(() => sharedPreferences.getString(any())).called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test('should throw [ServerException] when endpoint is not found',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(tServerException);

        when(() => sharedPreferences.getString(any())).thenReturn(kToken);

        final call = dataSource.signInWithCredential;
        expect(
          () => call(),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);

        verify(() => sharedPreferences.getString(any())).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });
    },
  );

  // group('updateUser', () {
  //   setUp(() {
  //     registerFallbackValue(MockAuthCredential());
  //   });
  //   test(
  //     'should update user displayName successfully when no [Exception] is thrown',
  //     () async {
  //       when(
  //         () => mockUser.updateDisplayName(any()),
  //       ).thenAnswer(
  //         (_) async => Future.value(),
  //       );

  //       await dataSource.updateUser(
  //         action: UpdateUserAction.name,
  //         userData: tName,
  //       );

  //       verify(
  //         () => mockUser.updateDisplayName(tName),
  //       ).called(1);

  //       verifyNever(() => mockUser.updateEmail(any()));
  //       verifyNever(() => mockUser.updatePhotoURL(any()));
  //       verifyNever(() => mockUser.updatePassword(any()));

  //       final userData =
  //           await cloudStoreClient.collection('users').doc(mockUser.uid).get();

  //       expect(userData.data()!['name'], tName);
  //     },
  //   );

  //   test(
  //     'should update user email successfully when no [Exception] is thrown',
  //     () async {
  //       when(
  //         () => mockUser.updateEmail(any()),
  //       ).thenAnswer(
  //         (_) async => Future.value(),
  //       );

  //       await dataSource.updateUser(
  //         action: UpdateUserAction.email,
  //         userData: tEmail,
  //       );

  //       verify(
  //         () => mockUser.updateEmail(tEmail),
  //       ).called(1);

  //       verifyNever(() => mockUser.updateDisplayName(any()));
  //       verifyNever(() => mockUser.updatePhotoURL(any()));
  //       verifyNever(() => mockUser.updatePassword(any()));

  //       final userData =
  //           await cloudStoreClient.collection('users').doc(mockUser.uid).get();

  //       expect(userData.data()!['email'], tEmail);
  //     },
  //   );

  //   test(
  //     'should update user profilePic successfully when no [Exception] is thrown',
  //     () async {
  //       final newProfilePic = File('assets/images/backround.png');

  //       when(
  //         () => mockUser.updatePhotoURL(any()),
  //       ).thenAnswer(
  //         (_) async => Future.value(),
  //       );

  //       await dataSource.updateUser(
  //         action: UpdateUserAction.profilePic,
  //         userData: newProfilePic,
  //       );

  //       verify(
  //         () => mockUser.updatePhotoURL(any()),
  //       ).called(1);

  //       verifyNever(() => mockUser.updateDisplayName(any()));
  //       verifyNever(() => mockUser.updatePassword(any()));
  //       verifyNever(() => mockUser.updateEmail(any()));

  //       expect(dbClient.storedFilesMap.isNotEmpty, isTrue);
  //     },
  //   );

  //   test(
  //     'should update user password successfully when no [Exception] is thrown',
  //     () async {
  //       when(
  //         () => mockUser.updatePassword(any()),
  //       ).thenAnswer(
  //         (_) async => Future.value(),
  //       );

  //       when(
  //         () => mockUser.reauthenticateWithCredential(any()),
  //       ).thenAnswer((_) async => userCredential);

  //       when(
  //         () => mockUser.email,
  //       ).thenReturn(tEmail);

  //       await dataSource.updateUser(
  //         action: UpdateUserAction.password,
  //         userData: jsonEncode(
  //           {
  //             'oldPassword': 'oldPassword',
  //             'newPassword': tPassword,
  //           },
  //         ),
  //       );

  //       verify(
  //         () => mockUser.updatePassword(tPassword),
  //       ).called(1);

  //       verifyNever(() => mockUser.updateDisplayName(any()));
  //       verifyNever(() => mockUser.updatePhotoURL(any()));
  //       verifyNever(() => mockUser.updateEmail(any()));

  //       final userData = await cloudStoreClient
  //           .collection('users')
  //           .doc(documentReference.id)
  //           .get();

  //       expect(userData.data()!['password'], null);
  //     },
  //   );
  // });
}
