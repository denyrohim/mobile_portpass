import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/scan_nfc_employee.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late ScanNFCEmployee usecase;

  // Sample NFC data for testing
  const tNFCData = '123456';

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = ScanNFCEmployee(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.scanNFCEmployee]',
    () async {
      // Mocking the repository's scanNFCEmployee method
      when(
        () => repository.scanNFCEmployee(),
      ).thenAnswer(
        (_) async => const Right(tNFCData),
      );

      // Calling the use case
      final result = await usecase();

      // Expecting the result to be a Right containing the NFC data
      expect(
        result,
        equals(const Right<String, dynamic>(tNFCData)),
      );

      // Verifying that the scanNFCEmployee method was called
      verify(() => repository.scanNFCEmployee()).called(1);

      // Verifying that no other interactions occurred with the repository
      verifyNoMoreInteractions(repository);
    },
  );
}
