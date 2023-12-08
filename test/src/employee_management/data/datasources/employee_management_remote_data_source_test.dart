import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/core/utils/constanst.dart';
import 'package:port_pass_app/src/employee_management/data/datasources/employee_management_remote_data_source.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_division_model.dart';
import 'package:port_pass_app/src/employee_management/data/models/employee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

class MockAPI extends Mock implements API {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  late EmploymentManagementRemoteDataSourceImpl dataSource;
  late SharedPreferences sharedPreferences;
  late Dio dio;
  late API api;
  late ImagePicker imagePicker;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    dio = MockDio();
    api = API();
    imagePicker = MockImagePicker();
    dataSource = EmploymentManagementRemoteDataSourceImpl(
      sharedPreferences: sharedPreferences,
      dio: dio,
      api: api,
      imagePicker: imagePicker,
    );
  });

  const tEmployee = EmployeeModel.empty();
  const tEmployeeDivision = EmployeeDivisionModel.empty();
  const tUpdateEmployeeAction = [UpdateEmployeeAction.name];

  const tToken = 'token';

  final tResponseFailed = Response(
    data: {
      'message': 'ServerException',
      'data': null,
    },
    statusCode: 500,
    requestOptions: RequestOptions(path: ''),
  );
  const String tModifiedEmployeePhotoUrl =
      '$kBaseUrl/images/employee/photo.jpg';

  final tResponseSuccess = Response<dynamic>(
    data: {
      'message': 'Success',
      'data': [tEmployee.toMap(), tEmployee.toMap()],
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseSuccessDivision = Response<dynamic>(
    data: {
      'message': 'Success',
      'data': [tEmployeeDivision.toMap(), tEmployeeDivision.toMap()],
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );
  final tResponseSuccessDivisionNoData = Response<dynamic>(
    data: {
      'message': 'Success',
      'data': [],
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );
  const tSourceCamera = ImageSource.camera;
  const tSourceGallery = ImageSource.gallery;

  final tResponseUpdateSuccess = Response<dynamic>(
    data: {
      'message': 'Success',
      'data': const EmployeeModel(
        id: 0,
        name: 'John Doe',
        email: '',
        phone: '',
        dateOfBirth: '',
        employeeDivisionId: 0,
        employeeType: 'Organik',
        nik: '',
        cardStart: '',
        cardStop: '',
        cardNumber: '',
        photo: '',
        isChecked: false,
      ).toMap(),
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseUpdateSuccessWithProfileImg = Response<dynamic>(
    data: {
      'data': [
        const EmployeeModel.empty().toMap(),
        const EmployeeModel(
          id: 0,
          name: 'Testing',
          email: '',
          phone: '',
          dateOfBirth: '',
          employeeDivisionId: 0,
          employeeType: 'Organik',
          nik: '',
          cardStart: '',
          cardStop: '',
          cardNumber: '',
          photo: 'photo.jpg',
          isChecked: false,
        ).toMap()
      ],
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseNoData = Response<dynamic>(
    data: {
      'data': [],
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  const tServerException = ServerException(
    message: 'ServerException',
    statusCode: 500,
  );

  final tXFile = XFile('path');

  setUpAll(() {
    registerFallbackValue(tSourceCamera);
    registerFallbackValue(tSourceGallery);
    registerFallbackValue(tXFile);
  });
  group('addEmployee', () {
    test('should add an employee successfully', () async {
      when(() => sharedPreferences.getString(any())).thenReturn(tToken);
      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseSuccess);

      final call = dataSource.addEmployee;

      expect(
          call(
            employeeData: tEmployee,
          ),
          completes);

      verify(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).called(1);
      verifyNoMoreInteractions(dio);

      verify(() => sharedPreferences.getString(any())).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('should throw ServerException when token is null', () {
      when(() => sharedPreferences.getString(any())).thenReturn(null);

      final call = dataSource.addEmployee;

      expect(
        () => call(
          employeeData: tEmployee,
        ),
        throwsA(isA<ServerException>()),
      );

      verify(() => sharedPreferences.getString(any())).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });

  group('deleteEmployees', () {
    const kToken = 'token';
    const tIds = [1, 2, 3];

    test('deleteEmployees - should delete employees successfully', () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => Response(
            data: {'message': 'Success'},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final call = dataSource.deleteEmployees(ids: tIds);

      // Assert
      await expectLater(
        call,
        completes,
      );

      verify(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('deleteEmployees - should throw ServerException when token is null',
        () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(null);

      // Act
      final call = dataSource.deleteEmployees(ids: tIds);

      // Assert
      await expectLater(
        call,
        throwsA(isA<ServerException>()),
      );

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('deleteEmployees - should throw ServerException on API error',
        () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => Response(
            data: {'message': 'Error'},
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final call = dataSource.deleteEmployees(ids: tIds);

      // Assert
      await expectLater(
        call,
        throwsA(isA<ServerException>()),
      );

      verify(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });

  group('getEmployees', () {
    test('getEmployees - should get employees successfully', () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseSuccess);

      // Act
      final result = await dataSource.getEmployees();

      // Assert
      expect(result, isA<List<EmployeeModel>>());
      expect(result.length, equals(2));

      verify(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('getEmployees - should handle null photo path', () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseUpdateSuccessWithProfileImg);

      // Act
      final result = await dataSource.getEmployees();

      // Assert
      expect(result, isA<List<EmployeeModel>>());
      expect(result.length, equals(2));

      // Check that the photo path is changed for the first employee
      expect(result[0].photo, isNull);

      // Check that the photo path is unchanged for the second employee
      expect(
        result[1].photo,
        equals(tModifiedEmployeePhotoUrl),
      );

      verify(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('getEmployees - should handle no data', () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseNoData);

      // Act
      final result = await dataSource.getEmployees();

      // Assert
      expect(result, isA<List<EmployeeModel>>());
      expect(result.isEmpty, isTrue);

      verify(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('getEmployees - should throw ServerException on API error', () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseFailed);

      // Act
      final call = dataSource.getEmployees();

      // Assert
      await expectLater(
        call,
        throwsA(isA<ServerException>()),
      );

      verify(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });

  group('updateEmployee', () {
    test('updateEmployee - should update employee successfully', () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.put(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseUpdateSuccess);

      // Act
      final result = await dataSource.updateEmployee(
        actions: tUpdateEmployeeAction,
        employee: tEmployee,
      );

      // Assert
      expect(result, isA<EmployeeModel>());

      // Check that the updated employee data is returned
      expect(result.id, equals(0));
      expect(result.name, equals('John Doe'));

      verify(
        () => dio.put(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('updateEmployee - should throw ServerException on API error',
        () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.put(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseFailed);

      // Act
      final call = dataSource.updateEmployee(
        actions: tUpdateEmployeeAction,
        employee: tEmployee,
      );

      // Assert
      await expectLater(
        call,
        throwsA(isA<ServerException>()),
      );

      verify(
        () => dio.put(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });

  group('scanNFCEmployee', () {
    test('scanNFCEmployee - should scan NFC successfully', () async {});

    test(
        'scanNFCEmployee - should throw ServerException when NFC is not available',
        () async {});

    test('scanNFCEmployee - should throw ServerException on NFC scan error',
        () async {});
  });

  group('addPhoto', () {
    test('addPhoto - should return a File when adding a photo', () async {
      // Arrange
      const type = 'camera';
      when(() => imagePicker.pickImage(
            source: any(named: 'source'),
            imageQuality: any(named: 'imageQuality'),
            maxWidth: any(named: 'maxWidth'),
          )).thenAnswer((_) async => tXFile);

      // Act
      final result = await dataSource.addPhotoEmployee(type: type);

      // Assert
      expect(result, isA<File>());

      verify(
        () => imagePicker.pickImage(
          source: tSourceCamera,
          imageQuality: any(named: 'imageQuality'),
          maxWidth: any(named: 'maxWidth'),
        ),
      ).called(1);

      verifyNoMoreInteractions(imagePicker);
    });

    test('addPhoto - should return null when type is "remove"', () async {
      // Arrange
      const type = 'remove';

      // Act
      final result = await dataSource.addPhotoEmployee(type: type);

      // Assert
      expect(result, isNull);

      verifyZeroInteractions(imagePicker);
    });

    test('addPhoto - should throw ServerException when access is denied',
        () async {
      // Arrange
      const type = 'camera';
      when(() => imagePicker.pickImage(
            source: any(named: 'source'),
            imageQuality: any(named: 'imageQuality'),
            maxWidth: any(named: 'maxWidth'),
          )).thenAnswer((_) async => null);

      // Act
      final call = dataSource.addPhotoEmployee(type: type);

      // Assert
      await expectLater(
        call,
        throwsA(isA<ServerException>()),
      );

      verify(
        () => imagePicker.pickImage(
          source: tSourceCamera,
          imageQuality: 50,
          maxWidth: 150,
        ),
      ).called(1);

      verifyNoMoreInteractions(imagePicker);
    });

    test('addPhoto - should throw ServerException on general error', () async {
      // Arrange
      const type = 'camera';
      when(() => imagePicker.pickImage(
            source: any(named: 'source'),
            imageQuality: any(named: 'imageQuality'),
            maxWidth: any(named: 'maxWidth'),
          )).thenThrow(tServerException);

      // Act
      final call = dataSource.addPhotoEmployee(type: type);

      // Assert
      await expectLater(
        call,
        throwsA(isA<ServerException>()),
      );

      verify(
        () => imagePicker.pickImage(
          source: tSourceCamera,
          imageQuality: 50,
          maxWidth: 150,
        ),
      ).called(1);

      verifyNoMoreInteractions(imagePicker);
    });
  });

  group('getEmployeeDivision', () {
    test('getEmployeeDivision - should get employee divisions successfully',
        () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseSuccessDivision);

      // Act
      final result = await dataSource.getEmployeeDivision();

      // Assert
      expect(result, isA<List<EmployeeDivisionModel>>());
      expect(result.length, equals(2));

      verify(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('getEmployeeDivision - should handle no data', () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseSuccessDivisionNoData);

      // Act
      final result = await dataSource.getEmployeeDivision();

      // Assert
      expect(result, isA<List<EmployeeDivisionModel>>());
      expect(result.isEmpty, isTrue);

      verify(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test('getEmployeeDivision - should throw ServerException on API error',
        () async {
      // Arrange
      when(() => sharedPreferences.getString(kToken)).thenReturn(tToken);
      when(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => tResponseFailed);

      // Act
      final call = dataSource.getEmployeeDivision();

      // Assert
      await expectLater(
        call,
        throwsA(isA<ServerException>()),
      );

      verify(
        () => dio.get(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(
        () => sharedPreferences.getString(kToken),
      ).called(1);

      verifyNoMoreInteractions(dio);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });
}
