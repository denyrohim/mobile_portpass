import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_model.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tEmployeeModel = EmployeeModel.empty();

  test('should be a subclass of [Employee] entity',
      () => expect(tEmployeeModel, isA<Employee>()));

  final tMap = jsonDecode(fixture('employee.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [EmployeeModel] from the Map', () {
      final result = EmployeeModel.fromMap(tMap);

      expect(result, equals(tEmployeeModel));
    });

    test('should throw an Error when the map is invalid ', () {
      final map = DataMap.from(tMap)..remove('id');

      expect(() => EmployeeModel.fromMap(map), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      final result = tEmployeeModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a valid [EmployeeModel] with updated value', () {
      final result = tEmployeeModel.copyWith(
        name: 'NewTestingName',
        email: 'new_email@example.com',
      );

      expect(result.name, equals('NewTestingName'));
      expect(result.email, equals('new_email@example.com'));
    });
  });
}
