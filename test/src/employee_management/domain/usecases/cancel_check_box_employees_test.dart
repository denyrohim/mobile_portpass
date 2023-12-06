import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/cancel_check_box_employees.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late CancelCheckBoxEmployees usecase;

  const tEmployees = [
    Employee.empty(),
    Employee.empty(),
  ];

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = CancelCheckBoxEmployees(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.cancelCheckBoxEmployees]',
    () async {
      when(
        () => repository.cancelCheckBoxEmployees(
          employees: tEmployees,
        ),
      ).thenAnswer(
        (_) async => const Right(tEmployees),
      );

      final result = await usecase(tEmployees);

      expect(result,
          equals(const Right<List<Employee>, List<Employee>>(tEmployees)));

      verify(() => repository.cancelCheckBoxEmployees(employees: tEmployees))
          .called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
