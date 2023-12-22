import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_route.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class GetActivityRoutes implements UsecaseWithoutParams<List<ActivityRoute>> {
  const GetActivityRoutes(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<List<ActivityRoute>> call() => _repository.getActivityRoutes();
}
