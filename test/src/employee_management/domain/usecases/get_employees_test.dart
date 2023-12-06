import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/get_employees.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late GetEmployees usecase;

  // Sample employees for testing
  const tEmployees = [
    Employee.empty(),
    Employee.empty(),
  ];

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = GetEmployees(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.getEmployees]',
    () async {
      // Mocking the repository's getEmployees method
      when(
        () => repository.getEmployees(),
      ).thenAnswer(
        (_) async => const Right(tEmployees),
      );

      // Calling the use case
      final result = await usecase();

      // Expecting the result to be a Right containing the list of employees
      expect(
        result,
        equals(const Right<List<Employee>, dynamic>(tEmployees)),
      );

      // Verifying that the getEmployees method was called
      verify(() => repository.getEmployees()).called(1);

      // Verifying that no other interactions occurred with the repository
      verifyNoMoreInteractions(repository);
    },
  );
}
