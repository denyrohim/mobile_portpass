import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/auth/domain/usecases/update_user.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late UpdateUser usecase;

  final tUpdateUserParams = UpdateUserParams.empty();

  setUp(() {
    repository = MockAuthRepo();
    usecase = UpdateUser(repository);
  });

  const tUser = LocalUser.empty();

  setUpAll(() {
    registerFallbackValue(tUser);
  });

  test(
    'should call the [AuthRepo.updateUser]',
    () async {
      when(
        () => repository.updateUser(
          actions: any(named: 'actions'),
          userData: any(named: 'userData'),
        ),
      ).thenAnswer(
        (_) async => const Right(tUser),
      );

      final result = await usecase(
        UpdateUserParams(
          actions: tUpdateUserParams.actions,
          userData: tUpdateUserParams.userData,
        ),
      );

      expect(result, equals(const Right<dynamic, LocalUser>(tUser)));

      verify(
        () => repository.updateUser(
          actions: any(named: 'actions'),
          userData: any(named: 'userData'),
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
