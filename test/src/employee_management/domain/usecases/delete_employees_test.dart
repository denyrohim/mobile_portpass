import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/delete_employees.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late DeleteEmployees usecase;

  final tIds = [1, 2, 3];

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = DeleteEmployees(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.deleteEmployees]',
    () async {
      when(
        () => repository.deleteEmployees(
          ids: tIds,
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tIds);

      expect(result, equals(const Right<void, dynamic>(null)));

      verify(() => repository.deleteEmployees(ids: tIds)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
