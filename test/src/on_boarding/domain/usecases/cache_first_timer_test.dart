import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:port_pass_app/src/on_boarding/domain/usecases/cache_first_timer.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CacheFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repository);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer] and return the right data',
    () async {
      when(() => repository.cacheFirstTimer()).thenAnswer(
        (_) async => const Left(
          ServerFailure(
            message: 'Unknown Error Occured',
            statusCode: 500,
          ),
        ),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          const Left<Failure, dynamic>(
            ServerFailure(
              message: 'Unknown Error Occured',
              statusCode: 500,
            ),
          ),
        ),
      );

      verify(() => repository.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
