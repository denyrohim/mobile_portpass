import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/add_employee.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late AddEmployee usecase;

  const tEmployee = Employee.empty();

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = AddEmployee(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.addEmployee]',
    () async {
      when(
        () => repository.addEmployee(
          employeeData: tEmployee,
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tEmployee);

      expect(result, equals(const Right<void, dynamic>(null)));

      verify(() => repository.addEmployee(employeeData: tEmployee)).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
