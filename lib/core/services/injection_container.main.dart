part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  final api = API();
  final imagePicker = ImagePicker();
  final geolocator = GeolocatorPlatform.instance;

  await _initCore(
      prefs: prefs,
      dio: dio,
      api: api,
      imagePicker: imagePicker,
      geolocator: geolocator);
  await _initAuth();
  await _initEmployeeManagement();
  await _initActivityManagement();
  await _initGateReport();
}

Future<void> _initCore({
  required SharedPreferences prefs,
  required Dio dio,
  required API api,
  required ImagePicker imagePicker,
  required GeolocatorPlatform geolocator,
}) async {
  sl
    ..registerLazySingleton(() => dio)
    ..registerLazySingleton(() => api)
    ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(() => imagePicker)
    ..registerLazySingleton(() => geolocator);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signInWithCredential: sl(),
        updateUser: sl(),
        signOut: sl(),
        addPhoto: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignInWithCredential(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => AddPhoto(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        sharedPreferences: sl(),
        dio: sl(),
        api: sl(),
      ),
    );
}

Future<void> _initEmployeeManagement() async {
  sl
    ..registerFactory(
      () => EmployeeManagementBloc(
        addEmployee: sl(),
        deleteEmployees: sl(),
        updateEmployee: sl(),
        getEmployees: sl(),
        updateCheckBoxEmployee: sl(),
        cancelCheckBoxEmployees: sl(),
        selectAllEmployees: sl(),
        scanNFCEmployee: sl(),
        addPhoto: sl(),
        getEmployeeDivision: sl(),
      ),
    )
    ..registerLazySingleton(() => AddEmployee(sl()))
    ..registerLazySingleton(() => DeleteEmployees(sl()))
    ..registerLazySingleton(() => GetEmployees(sl()))
    ..registerLazySingleton(() => UpdateEmployee(sl()))
    ..registerLazySingleton(() => UpdateCheckBoxEmployee(sl()))
    ..registerLazySingleton(() => CancelCheckBoxEmployees(sl()))
    ..registerLazySingleton(() => SelectAllEmployees(sl()))
    ..registerLazySingleton(() => ScanNFCEmployee(sl()))
    ..registerLazySingleton(() => AddPhotoEmployee(sl()))
    ..registerLazySingleton(() => GetEmployeeDivision(sl()))
    ..registerLazySingleton<EmployeeManagementRepository>(
        () => EmployeeManagementRepositoryImpl(sl()))
    ..registerLazySingleton<EmploymentManagementRemoteDataSource>(
      () => EmploymentManagementRemoteDataSourceImpl(
        sharedPreferences: sl(),
        dio: sl(),
        api: sl(),
        imagePicker: sl(),
      ),
    );
}

Future<void> _initActivityManagement() async {
  sl
    ..registerFactory(
      () => ActivityManagementBloc(
        addActivity: sl(),
        addItem: sl(),
        deleteActivities: sl(),
        deleteItems: sl(),
        getActivities: sl(),
        updateActivity: sl(),
        updateItem: sl(),
        addPhotoItem: sl(),
        changeStatusActivities: sl(),
        cancelCheckBoxActivities: sl(),
        updateCheckBoxActivity: sl(),
        selectAllActivities: sl(),
      ),
    )
    ..registerLazySingleton(() => AddActivity(sl()))
    ..registerLazySingleton(() => AddItem(sl()))
    ..registerLazySingleton(() => DeleteActivities(sl()))
    ..registerLazySingleton(() => DeleteItems(sl()))
    ..registerLazySingleton(() => GetActivities(sl()))
    ..registerLazySingleton(() => UpdateActivity(sl()))
    ..registerLazySingleton(() => UpdateItem(sl()))
    ..registerLazySingleton(() => AddPhotoItem(sl()))
    ..registerLazySingleton(() => ChangeStatusActivities(sl()))
    ..registerLazySingleton(() => CancelCheckBoxActivities(sl()))
    ..registerLazySingleton(() => UpdateCheckBoxActivity(sl()))
    ..registerLazySingleton(() => SelectAllActivities(sl()))
    ..registerLazySingleton<ActivityManagementRepository>(
        () => ActivityManagementRepositoryImpl(sl()))
    ..registerLazySingleton<ActivityManagementRemoteDataSource>(
      () => ActivityManagementRemoteDataSourceImpl(
          sharedPreferences: sl(), dio: sl(), api: sl(), imagePicker: sl()),
    );
}

Future<void> _initGateReport() async {
  final filePicker = FilePicker.platform;
  sl
    ..registerFactory(
      () => GateReportBloc(
        addDocumentation: sl(),
        scanQRActivity: sl(),
        getLocation: sl(),
        addReport: sl(),
        addUrgentLetter: sl(),
        getActivity: sl(),
      ),
    )
    ..registerLazySingleton(() => AddReport(sl()))
    ..registerLazySingleton(() => GetActivity(sl()))
    ..registerLazySingleton(() => GetLocation(sl()))
    ..registerLazySingleton(() => ScanQRActivity(sl()))
    ..registerLazySingleton(() => AddUrgentLetter(sl()))
    ..registerLazySingleton(() => AddDocumentation(sl()))
    ..registerLazySingleton<GateReportRepository>(
        () => GateReportRepositoryImpl(sl()))
    ..registerLazySingleton(() => filePicker)
    ..registerLazySingleton<GateReportRemoteDataSource>(
      () => GateReportRemoteDataSourceImpl(
        sharedPreferences: sl(),
        dio: sl(),
        api: sl(),
        filePicker: sl(),
        imagePicker: sl(),
        geolocator: sl(),
      ),
    );
}
