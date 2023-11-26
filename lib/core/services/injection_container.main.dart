part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  final api = API();

  await _initCore(prefs: prefs, dio: dio, api: api);
  await _initAuth();
  await _initEmployeeManagement();
  await _initActivityManagement();
}

Future<void> _initCore({
  required SharedPreferences prefs,
  required Dio dio,
  required API api,
}) async {
  sl
    ..registerLazySingleton(() => dio)
    ..registerLazySingleton(() => api)
    ..registerLazySingleton(() => prefs);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signInWithCredential: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignInWithCredential(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
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
      ),
    )
    ..registerLazySingleton(() => AddEmployee(sl()))
    ..registerLazySingleton(() => DeleteEmployees(sl()))
    ..registerLazySingleton(() => GetEmployees(sl()))
    ..registerLazySingleton(() => UpdateEmployee(sl()))
    ..registerLazySingleton(() => UpdateCheckBoxEmployee(sl()))
    ..registerLazySingleton(() => CancelCheckBoxEmployees(sl()))
    ..registerLazySingleton(() => SelectAllEmployees(sl()))
    ..registerLazySingleton<EmployeeManagementRepository>(
        () => EmployeeManagementRepositoryImpl(sl()))
    ..registerLazySingleton<EmploymentManagementRemoteDataSource>(
      () => EmploymentManagementRemoteDataSourceImpl(
        sharedPreferences: sl(),
        dio: sl(),
        api: sl(),
      ),
    );
}

Future<void> _initActivityManagement() async {
  sl
    // ..registerFactory(
    //   () => AuthBloc(
    //     signIn: sl(),
    //     signInWithCredential: sl(),
    //   ),
    // )
    ..registerLazySingleton(() => AddActivity(sl()))
    ..registerLazySingleton(() => AddItem(sl()))
    ..registerLazySingleton(() => DeleteActivities(sl()))
    ..registerLazySingleton(() => DeleteItems(sl()))
    ..registerLazySingleton(() => GetActivities(sl()))
    ..registerLazySingleton(() => UpdateActivity(sl()))
    ..registerLazySingleton(() => UpdateItem(sl()))
    ..registerLazySingleton<ActivityManagementRepository>(
        () => ActivityManagementRepositoryImpl(sl()))
    ..registerLazySingleton<ActivityManagementRemoteDataSource>(
      () => ActivityManagementRemoteDataSourceImpl(
        sharedPreferences: sl(),
        dio: sl(),
        api: sl(),
      ),
    );
}
