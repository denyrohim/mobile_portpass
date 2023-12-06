import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/add_photo_employee.dart';

import 'employee_management_repository.mock.dart';

void main() {
  late EmployeeManagementRepository repository;
  late AddPhotoEmployee usecase;

  const tType = 'camera';
  final tFile = File('path');

  setUp(() {
    repository = MockEmployeeManagementRepo();
    usecase = AddPhotoEmployee(repository);
  });

  test(
    'should call the [EmployeeManagementRepo.addPhotoEmployee]',
    () async {
      when(
        () => repository.addPhoto(
          type: tType,
        ),
      ).thenAnswer(
        (_) async => Right(tFile),
      );

      final result = await usecase(tType);

      expect(result, equals(Right<dynamic, File>(tFile)));

      verify(() => repository.addPhoto(type: tType)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
