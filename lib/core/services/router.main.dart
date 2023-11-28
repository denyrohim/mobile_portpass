part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case '/':
    //   return _pageBuilder(
    //     (context) {
    //       const localUser = LocalUserModel(
    //         id: -99,
    //         email: 'email',
    //         name: 'name',
    //         role: 'agent',
    //       );
    //       context.userProvider.initUser(localUser);
    //       return const Dashboard();
    //       // return BlocProvider(
    //       //   create: (_) => sl<AuthBloc>(),
    //       //   child: const Dashboard(),
    //       // );
    //     },
    //     settings: settings,
    //   );

    case '/':
      return _pageBuilder(
        (_) => const AddEmployeeScreen(),
        settings: settings,
      );

    case SplashScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SplashScreen(),
        ),
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case Dashboard.routeName:
      return _pageBuilder(
        (_) => const Dashboard(),
        settings: settings,
      );
    case ProfileScreen.routeName:
      return _pageBuilder(
        (_) => const ProfileScreen(),
        settings: settings,
      );
    case HomeGateReportScreen.routeName:
      return _pageBuilder(
        (_) => const HomeGateReportScreen(),
        settings: settings,
      );
    case DetailActivityScreen.routeName:
      return _pageBuilder(
        (_) => const DetailActivityScreen(),
        settings: settings,
      );
    case ScanQRCodeScreen.routeName:
      return _pageBuilder(
        (_) => const ScanQRCodeScreen(),
        settings: settings,
      );
    case QRCodeActivityScreen.routeName:
      return _pageBuilder(
        (_) => const QRCodeActivityScreen(),
        settings: settings,
      );
    case AddEmployeeScreen.routeName:
      return _pageBuilder(
        (_) => const AddEmployeeScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings? settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
