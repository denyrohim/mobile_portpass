import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/select_all_employees.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late SelectAllEmployees usecase;

  // Sample employees for testing
  const tEmployees = [
    Employee.empty(),
    Employee.empty(),
  ];

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = SelectAllEmployees(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.selectAllEmployees]',
    () async {
      // Mocking the repository's selectAllEmployees method
      when(
        () => repository.selectAllEmployees(
          employees: tEmployees,
        ),
      ).thenAnswer(
        (_) async => const Right(tEmployees),
      );

      // Calling the use case
      final result = await usecase(tEmployees);

      // Expecting the result to be a Right containing the list of selected employees
      expect(
        result,
        equals(const Right<List<Employee>, dynamic>(tEmployees)),
      );

      // Verifying that the selectAllEmployees method was called with the correct parameters
      verify(() => repository.selectAllEmployees(employees: tEmployees))
          .called(1);

      // Verifying that no other interactions occurred with the repository
      verifyNoMoreInteractions(repository);
    },
  );
}
