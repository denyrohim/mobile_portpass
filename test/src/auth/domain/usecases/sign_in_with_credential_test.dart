import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in_with_credential.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late SignInWithCredential usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignInWithCredential(repository);
  });

  const tUser = LocalUser.empty();

  test(
    'should call the [AuthRepo.signIn]',
    () async {
      when(
        () => repository.signInWithCredential(),
      ).thenAnswer(
        (_) async => const Right(tUser),
      );

      final result = await usecase();

      expect(result, equals(const Right<dynamic, LocalUser>(tUser)));

      verify(() => repository.signInWithCredential()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
