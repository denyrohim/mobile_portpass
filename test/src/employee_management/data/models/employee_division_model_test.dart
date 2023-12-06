import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_division_model.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tEmployeeDivisionModel = EmployeeDivisionModel.empty();

  test('should be a subclass of [EmployeeDivision] entity',
      () => expect(tEmployeeDivisionModel, isA<EmployeeDivision>()));

  final tMap = jsonDecode(fixture('employee_division.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [EmployeeDivisionModel] from the Map', () {
      final result = EmployeeDivisionModel.fromMap(tMap);

      expect(result, equals(tEmployeeDivisionModel));
    });

    test('should throw an Error when the map is invalid ', () {
      final map = DataMap.from(tMap)..remove('id');

      expect(() => EmployeeDivisionModel.fromMap(map), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      final result = tEmployeeDivisionModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a valid [EmployeeDivisionModel] with updated value',
        () {
      final result = tEmployeeDivisionModel.copyWith(
        name: 'NewDivisionName',
      );

      expect(result.name, equals('NewDivisionName'));
    });
  });
}
