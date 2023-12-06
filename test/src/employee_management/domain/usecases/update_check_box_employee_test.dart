import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_check_box_employee.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late UpdateCheckBoxEmployee usecase;

  // Sample parameters for testing
  const tParams = UpdateCheckBoxEmployeeParams(
    employeeId: 1,
    employees: [Employee.empty(), Employee.empty()],
  );

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = UpdateCheckBoxEmployee(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.updateCheckBoxEmployee]',
    () async {
      // Mocking the repository's updateCheckBoxEmployee method
      when(
        () => repository.updateCheckBoxEmployee(
          employeeId: tParams.employeeId,
          employees: tParams.employees,
        ),
      ).thenAnswer(
        (_) async => Right(tParams.employees),
      );

      // Calling the use case
      final result = await usecase(tParams);

      // Expecting the result to be a Right containing the updated list of employees
      expect(
        result,
        equals(Right<List<Employee>, dynamic>(tParams.employees)),
      );

      // Verifying that the updateCheckBoxEmployee method was called with the correct parameters
      verify(() => repository.updateCheckBoxEmployee(
            employeeId: tParams.employeeId,
            employees: tParams.employees,
          )).called(1);

      // Verifying that no other interactions occurred with the repository
      verifyNoMoreInteractions(repository);
    },
  );
}
