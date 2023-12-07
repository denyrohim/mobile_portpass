import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_type_model.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_type.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tEmployeeTypeModel = EmployeeTypeModel.empty();

  test('should be a subclass of [EmployeeType] entity',
      () => expect(tEmployeeTypeModel, isA<EmployeeType>()));

  final tMap = jsonDecode(fixture('employee_type.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [EmployeeTypeModel] from the Map', () {
      final result = EmployeeTypeModel.fromMap(tMap);

      expect(result, equals(tEmployeeTypeModel));
    });

    test('should throw an Error when the map is invalid ', () {
      final map = DataMap.from(tMap)..remove('id');

      expect(() => EmployeeTypeModel.fromMap(map), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      final result = tEmployeeTypeModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a valid [EmployeeTypeModel] with updated value', () {
      final result = tEmployeeTypeModel.copyWith(
        name: 'NewTypeName',
      );

      expect(result.name, equals('NewTypeName'));
    });
  });
}
