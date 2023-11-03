import 'package:bloc_test/bloc_test.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/src/auth/data/models/user_model.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in_with_credential.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignInWithCredential extends Mock implements SignInWithCredential {}

void main() {
  late MockSignIn signIn;
  late MockSignInWithCredential signInWithCredential;
  late AuthBloc authBloc;

  const tSignInParams = SignInParams.empty();

  setUp(() {
    signIn = MockSignIn();
    signInWithCredential = MockSignInWithCredential();
    authBloc = AuthBloc(
      signIn: signIn,
      signInWithCredential: signInWithCredential,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignInParams);
  });

  tearDown(() => authBloc.close());

  test('InitialState must be [AuthInitial]', () {
    expect(authBloc.state, const AuthInitial());
  });

  const tServerFailure = ServerFailure(
    message:
        'There is no user record corresponding to this identifier. The user may have been deleted.',
    statusCode: '404',
  );

  group('signInEvent', () {
    const tUser = LocalUserModel.empty();

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, SignedIn] when [SignInEvent] is added",
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignInEvent(
            email: tSignInParams.email,
            password: tSignInParams.password,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        const SignedIn(tUser),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, AuthError] when signIn fails",
      build: () {
        when(() => signIn(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignInEvent(
            email: tSignInParams.email,
            password: tSignInParams.password,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  // group('updateUserEvent', () {
  //   blocTest<AuthBloc, AuthState>(
  //     "should emit [AuthLoading, UserUpdated] when [UserUpdatedEvent] is added and UserUpdated succeeds",
  //     build: () {
  //       when(() => updateUser(any()))
  //           .thenAnswer((_) async => const Right(null));
  //       return authBloc;
  //     },
  //     act: (bloc) {
  //       bloc.add(
  //         UpdateUserEvent(
  //           action: tUpdateUserParams.action,
  //           userData: tUpdateUserParams.userData,
  //         ),
  //       );
  //     },
  //     expect: () => [
  //       const AuthLoading(),
  //       const UserUpdated(),
  //     ],
  //     verify: (_) {
  //       verify(() => updateUser(tUpdateUserParams)).called(1);
  //       verifyNoMoreInteractions(updateUser);
  //     },
  //   );

  //   blocTest<AuthBloc, AuthState>(
  //     "should emit [AuthLoading, AuthError] when [UserUpdatedEvent] is added and UserUpdated fails",
  //     build: () {
  //       when(() => updateUser(any()))
  //           .thenAnswer((_) async => const Left(tServerFailure));
  //       return authBloc;
  //     },
  //     act: (bloc) {
  //       bloc.add(
  //         UpdateUserEvent(
  //           action: tUpdateUserParams.action,
  //           userData: tUpdateUserParams.userData,
  //         ),
  //       );
  //     },
  //     expect: () => [
  //       const AuthLoading(),
  //       AuthError(tServerFailure.errorMessage),
  //     ],
  //     verify: (_) {
  //       verify(() => updateUser(tUpdateUserParams)).called(1);
  //       verifyNoMoreInteractions(updateUser);
  //     },
  //   );
  // });

  group('SignInWithCredential', () {
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, SignedIn] when [SignInWithCredentialEvent] is added",
      build: () {
        when(() => signInWithCredential())
            .thenAnswer((_) async => const Right(LocalUserModel.empty()));
        return authBloc;
      },
      act: (bloc) async {
        bloc.add(
          const SignInWithCredentialEvent(),
        );
      },
      expect: () => [
        const AuthLoading(),
        const SignedIn(
          LocalUserModel.empty(),
        ),
      ],
      verify: (_) {
        verify(() => signInWithCredential()).called(1);
        verifyNoMoreInteractions(signInWithCredential);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, NotSignedIn] when [signInWithCredentialEvent] fails",
      build: () {
        when(() => signInWithCredential())
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          const SignInWithCredentialEvent(),
        );
      },
      expect: () => [
        const AuthLoading(),
        const NotSignedIn(),
      ],
      verify: (_) {
        verify(() => signInWithCredential()).called(1);
        verifyNoMoreInteractions(signInWithCredential);
      },
    );
  });
}
