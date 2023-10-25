import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class CacheFirstTimer implements UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer();
}
