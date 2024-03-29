import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late SignIn usecase;

  const tEmail = 'email';
  const tPassword = 'password';

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignIn(repository);
  });

  const tUser = LocalUser.empty();

  test(
    'should call the [AuthRepo.signIn]',
    () async {
      when(
        () => repository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => const Right(tUser),
      );

      final result = await usecase(
        const SignInParams(
          email: tEmail,
          password: tPassword,
        ),
      );

      expect(result, equals(const Right<dynamic, LocalUser>(tUser)));

      verify(() => repository.signIn(email: tEmail, password: tPassword))
          .called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
