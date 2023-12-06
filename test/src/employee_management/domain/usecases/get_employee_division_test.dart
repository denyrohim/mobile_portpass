import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/get_employee_division.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late GetEmployeeDivision usecase;

  // Sample employee divisions for testing
  const tEmployeeDivisions = [
    EmployeeDivision.empty(),
    EmployeeDivision.empty(),
  ];

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = GetEmployeeDivision(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.getEmployeeDivision]',
    () async {
      // Mocking the repository's getEmployeeDivision method
      when(
        () => repository.getEmployeeDivision(),
      ).thenAnswer(
        (_) async => const Right(tEmployeeDivisions),
      );

      // Calling the use case
      final result = await usecase();

      // Expecting the result to be a Right containing the list of employee divisions
      expect(
        result,
        equals(
            const Right<List<EmployeeDivision>, dynamic>(tEmployeeDivisions)),
      );

      // Verifying that the getEmployeeDivision method was called
      verify(() => repository.getEmployeeDivision()).called(1);

      // Verifying that no other interactions occurred with the repository
      verifyNoMoreInteractions(repository);
    },
  );
}
