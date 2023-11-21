part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  final api = API();

  await _initCore(prefs: prefs, dio: dio, api: api);
  await _initEmployeeManagement();
  await _initAuth();
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
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignInWithCredential(sl()))
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
    // ..registerFactory(
    //   () => AuthBloc(
    //     signIn: sl(),
    //     signInWithCredential: sl(),
    //   ),
    // )
    ..registerLazySingleton(() => AddEmployee(sl()))
    ..registerLazySingleton(() => DeleteEmployees(sl()))
    ..registerLazySingleton(() => GetEmployees(sl()))
    ..registerLazySingleton(() => UpdateEmployee(sl()))
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

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    // ON BOARDING
    // App Logic
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )

    // Use cases
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))

    // Repository
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(sl()),
    )

    // Data sources
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(sl()),
    )

    // EXTERNAL DEPENDENCIES
    ..registerLazySingleton(() => prefs);
}
