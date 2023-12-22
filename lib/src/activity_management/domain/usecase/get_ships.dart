import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/ship.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class GetShips implements UsecaseWithoutParams<List<Ship>> {
  const GetShips(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<List<Ship>> call() => _repository.getShip();
}
