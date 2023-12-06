import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/add_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/add_photo_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/cancel_check_box_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/delete_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/get_employee_division.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/get_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/scan_nfc_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/select_all_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_check_box_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_employee.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';

class MockAddEmployee extends Mock implements AddEmployee {}

class MockDeleteEmployees extends Mock implements DeleteEmployees {}

class MockUpdateEmployee extends Mock implements UpdateEmployee {}

class MockGetEmployees extends Mock implements GetEmployees {}

class MockUpdateCheckBoxEmployee extends Mock
    implements UpdateCheckBoxEmployee {}

class MockCancelCheckBoxEmployees extends Mock
    implements CancelCheckBoxEmployees {}

class MockSelectAllEmployees extends Mock implements SelectAllEmployees {}

class MockScanNFCEmployee extends Mock implements ScanNFCEmployee {}

class MockAddPhotoEmployee extends Mock implements AddPhotoEmployee {}

class MockGetEmployeeDivision extends Mock implements GetEmployeeDivision {}

void main() {
  late MockAddEmployee addEmployee;
  late MockDeleteEmployees deleteEmployees;
  late MockUpdateEmployee updateEmployee;
  late MockGetEmployees getEmployees;
  late MockUpdateCheckBoxEmployee updateCheckBoxEmployee;
  late MockCancelCheckBoxEmployees cancelCheckBoxEmployees;
  late MockSelectAllEmployees selectAllEmployees;
  late MockScanNFCEmployee scanNFCEmployee;
  late MockAddPhotoEmployee addPhoto;
  late MockGetEmployeeDivision getEmployeeDivision;
  late EmployeeManagementBloc employeeManagementBloc;

  const tEmployee = Employee.empty();
  final tUpdateEmployeeParams = UpdateEmployeeParams.empty();
  final tFile = File('test');
  const tEmployeeDivision = EmployeeDivision.empty();

  setUp(() {
    addEmployee = MockAddEmployee();
    deleteEmployees = MockDeleteEmployees();
    updateEmployee = MockUpdateEmployee();
    getEmployees = MockGetEmployees();
    updateCheckBoxEmployee = MockUpdateCheckBoxEmployee();
    cancelCheckBoxEmployees = MockCancelCheckBoxEmployees();
    selectAllEmployees = MockSelectAllEmployees();
    scanNFCEmployee = MockScanNFCEmployee();
    addPhoto = MockAddPhotoEmployee();
    getEmployeeDivision = MockGetEmployeeDivision();
    employeeManagementBloc = EmployeeManagementBloc(
      addEmployee: addEmployee,
      deleteEmployees: deleteEmployees,
      updateEmployee: updateEmployee,
      getEmployees: getEmployees,
      updateCheckBoxEmployee: updateCheckBoxEmployee,
      cancelCheckBoxEmployees: cancelCheckBoxEmployees,
      selectAllEmployees: selectAllEmployees,
      scanNFCEmployee: scanNFCEmployee,
      addPhoto: addPhoto,
      getEmployeeDivision: getEmployeeDivision,
    );
  });

  setUpAll(() {
    registerFallbackValue(tEmployee);
    registerFallbackValue(tUpdateEmployeeParams);
    registerFallbackValue(tFile);
    registerFallbackValue(tEmployeeDivision);
  });

  tearDown(() => employeeManagementBloc.close());

  test('InitialState must be [AuthInitial]', () {
    expect(employeeManagementBloc.state, const EmployeeManagementInitial());
  });

  const tServerFailure = ServerFailure(
    message:
        'There is no user record corresponding to this identifier. The user may have been deleted.',
    statusCode: '404',
  );

  group('addEmployeeEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, DataAdded] when [AddEmployeeEvent] is added",
      build: () {
        when(() => addEmployee(any()))
            .thenAnswer((_) async => const Right(null));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const AddEmployeeEvent(
            employeeData: tEmployee,
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        const DataAdded(),
      ],
      verify: (_) {
        verify(() => addEmployee(any())).called(1);
        verifyNoMoreInteractions(addEmployee);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeManagementError] when [addEmployeeEvent] fails",
      build: () {
        when(() => addEmployee(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const AddEmployeeEvent(
            employeeData: tEmployee,
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        EmployeeManagementError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => addEmployee(any())).called(1);
        verifyNoMoreInteractions(addEmployee);
      },
    );
  });

  group('deleteEmployeesEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, DataDeleted] when [DeleteEmployeesEvent] is added",
      build: () {
        when(() => deleteEmployees(any()))
            .thenAnswer((_) async => const Right(null));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const DeleteEmployeesEvent(
            employeesIds: [1, 2], // Example employee IDs
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        const DataDeleted(),
      ],
      verify: (_) {
        verify(() => deleteEmployees(any())).called(1);
        verifyNoMoreInteractions(deleteEmployees);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeManagementError] when [DeleteEmployeesEvent] fails",
      build: () {
        when(() => deleteEmployees(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const DeleteEmployeesEvent(
            employeesIds: [1, 2], // Example employee IDs
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        EmployeeManagementError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => deleteEmployees(any())).called(1);
        verifyNoMoreInteractions(deleteEmployees);
      },
    );
  });

  group('updateEmployeeEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, DataUpdated] when [UpdateEmployeeEvent] is added",
      build: () {
        when(() => updateEmployee(any()))
            .thenAnswer((_) async => const Right(tEmployee));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          UpdateEmployeeEvent(
            actions: tUpdateEmployeeParams.actions,
            employee: tEmployee,
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        const DataUpdated(tEmployee),
      ],
      verify: (_) {
        verify(() => updateEmployee(any())).called(1);
        verifyNoMoreInteractions(updateEmployee);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeManagementError] when [updateEmployeeEvent] fails",
      build: () {
        when(() => updateEmployee(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          UpdateEmployeeEvent(
            actions: tUpdateEmployeeParams.actions,
            employee: tEmployee,
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        EmployeeManagementError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => updateEmployee(
              any(),
            )).called(1);
        verifyNoMoreInteractions(updateEmployee);
      },
    );
  });

  group('cancelCheckBoxEmployeeEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, UnshowChecked] when [CancelCheckBoxEmployeeEvent] is added",
      build: () {
        when(() => cancelCheckBoxEmployees(any()))
            .thenAnswer((_) async => const Right([tEmployee]));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const CancelCheckBoxEmployeeEvent(
            employees: [tEmployee],
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        const UnshowChecked([tEmployee]),
      ],
      verify: (_) {
        verify(() => cancelCheckBoxEmployees([tEmployee])).called(1);
        verifyNoMoreInteractions(cancelCheckBoxEmployees);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeManagementError] when [cancelCheckBoxEmployeeEvent] fails",
      build: () {
        when(() => cancelCheckBoxEmployees(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const CancelCheckBoxEmployeeEvent(
            employees: [tEmployee],
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        EmployeeManagementError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => cancelCheckBoxEmployees([tEmployee])).called(1);
        verifyNoMoreInteractions(cancelCheckBoxEmployees);
      },
    );
  });

  group('selectAllEmployeesEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, SelectedAll] when [SelectAllEmployeesEvent] is added",
      build: () {
        when(() => selectAllEmployees(any()))
            .thenAnswer((_) async => const Right([tEmployee]));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const SelectAllEmployeesEvent(
            employees: [tEmployee],
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        const SelectedAll([tEmployee]),
      ],
      verify: (_) {
        verify(() => selectAllEmployees([tEmployee])).called(1);
        verifyNoMoreInteractions(selectAllEmployees);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeManagementError] when [selectAllEmployeesEvent] fails",
      build: () {
        when(() => selectAllEmployees(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(
          const SelectAllEmployeesEvent(
            employees: [tEmployee],
          ),
        );
      },
      expect: () => [
        const EmployeeManagementLoading(),
        EmployeeManagementError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => selectAllEmployees([tEmployee])).called(1);
        verifyNoMoreInteractions(selectAllEmployees);
      },
    );
  });

  group('scanNFCEmployeeEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, NFCScanSuccess] when [ScanNFCEmployeeEvent] is added",
      build: () {
        when(() => scanNFCEmployee())
            .thenAnswer((_) async => const Right('NFC123'));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(const ScanNFCEmployeeEvent());
      },
      expect: () => [
        const EmployeeManagementLoading(),
        const NFCScanSuccess('NFC123'),
      ],
      verify: (_) {
        verify(() => scanNFCEmployee()).called(1);
        verifyNoMoreInteractions(scanNFCEmployee);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, NFCScanFailed] when [scanNFCEmployeeEvent] fails",
      build: () {
        when(() => scanNFCEmployee())
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(const ScanNFCEmployeeEvent());
      },
      expect: () => [
        const EmployeeManagementLoading(),
        NFCScanFailed(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => scanNFCEmployee()).called(1);
        verifyNoMoreInteractions(scanNFCEmployee);
      },
    );
  });

  group('addPhotoEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, PhotoAdded] when [AddPhotoEvent] is added",
      build: () {
        when(() => addPhoto(any())).thenAnswer((_) async => Right(tFile));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(const AddPhotoEvent(
            type: "camera")); // Assuming PhotoType is an enum
      },
      expect: () => [
        const EmployeeManagementLoading(),
        PhotoAdded(tFile),
      ],
      verify: (_) {
        verify(() => addPhoto(any())).called(1);
        verifyNoMoreInteractions(addPhoto);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeManagementError] when [addPhotoEvent] fails",
      build: () {
        when(() => addPhoto(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(const AddPhotoEvent(type: "camera"));
      },
      expect: () => [
        const EmployeeManagementLoading(),
        EmployeeManagementError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => addPhoto(any())).called(1);
        verifyNoMoreInteractions(addPhoto);
      },
    );
  });

  group('getEmployeeDivisionEvent', () {
    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeDivisionLoaded] when [GetEmployeeDivisionEvent] is added",
      build: () {
        when(() => getEmployeeDivision())
            .thenAnswer((_) async => const Right([tEmployeeDivision]));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(const GetEmployeeDivisionEvent());
      },
      expect: () => [
        const EmployeeManagementLoading(),
        const EmployeeDivisionLoaded([tEmployeeDivision]),
      ],
      verify: (_) {
        verify(() => getEmployeeDivision()).called(1);
        verifyNoMoreInteractions(getEmployeeDivision);
      },
    );

    blocTest<EmployeeManagementBloc, EmployeeManagementState>(
      "should emit [EmployeeManagementLoading, EmployeeManagementError] when [getEmployeeDivisionEvent] fails",
      build: () {
        when(() => getEmployeeDivision())
            .thenAnswer((_) async => const Left(tServerFailure));
        return employeeManagementBloc;
      },
      act: (bloc) {
        bloc.add(const GetEmployeeDivisionEvent());
      },
      expect: () => [
        const EmployeeManagementLoading(),
        EmployeeManagementError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getEmployeeDivision()).called(1);
        verifyNoMoreInteractions(getEmployeeDivision);
      },
    );
  });
}
