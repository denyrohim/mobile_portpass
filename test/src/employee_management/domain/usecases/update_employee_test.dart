import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_employee.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late UpdateEmployee usecase;

  // Sample parameters for testing
  const tParams = UpdateEmployeeParams(
    actions: [UpdateEmployeeAction.name],
    employee: Employee.empty(),
  );

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = UpdateEmployee(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.updateEmployee]',
    () async {
      // Mocking the repository's updateEmployee method
      when(
        () => repository.updateEmployee(
          actions: tParams.actions,
          employee: tParams.employee,
        ),
      ).thenAnswer(
        (_) async => Right(tParams.employee),
      );

      // Calling the use case
      final result = await usecase(tParams);

      // Expecting the result to be a Right containing the updated employee
      expect(
        result,
        equals(Right<Employee, dynamic>(tParams.employee)),
      );

      // Verifying that the updateEmployee method was called with the correct parameters
      verify(() => repository.updateEmployee(
            actions: tParams.actions,
            employee: tParams.employee,
          )).called(1);

      // Verifying that no other interactions occurred with the repository
      verifyNoMoreInteractions(repository);
    },
  );
}
