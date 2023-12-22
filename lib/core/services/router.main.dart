part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
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
    case ActivityDetailActivityScreen.routeName:
      return _pageBuilder(
        (_) => ActivityDetailActivityScreen(
          activity: settings.arguments,
        ),
        settings: settings,
      );

    case AddEmployeePhotoScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<EmployeeManagementBloc>(),
          child: AddEmployeePhotoScreen(
            photoController: settings.arguments as TextEditingController,
          ),
        ),
        settings: settings,
      );
    case EditEmployeePhotoScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<EmployeeManagementBloc>(),
          child: EditEmployeePhotoScreen(
            photoController: settings.arguments as TextEditingController,
          ),
        ),
        settings: settings,
      );
    case EditPhotoProfileScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: EditPhotoProfileScreen(
            photoController: settings.arguments as TextEditingController,
          ),
        ),
        settings: settings,
      );
    case GateDetailActivityScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<GateReportBloc>(),
          child: const GateDetailActivityScreen(),
        ),
        settings: settings,
      );

    case AddReportScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<GateReportBloc>(),
          child: AddReportScreen(
            activity: settings.arguments as Activity,
          ),
        ),
        settings: settings,
      );

    case TrackingActivityScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ActivityManagementBloc>(),
          child: TrackingActivityScreen(
            activity: settings.arguments,
          ),
        ),
        settings: settings,
      );

    case GateTrackingActivityScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<GateReportBloc>(),
          child: GateTrackingActivityScreen(
            activity: settings.arguments,
          ),
        ),
        settings: settings,
      );

    case QRCodeActivityScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ActivityManagementBloc>(),
          child: QRCodeActivityScreen(
            activity: settings.arguments,
          ),
        ),
        settings: settings,
      );

    case EditActivityScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ActivityManagementBloc>(),
          child: EditActivityScreen(
            activity: settings.arguments,
          ),
        ),
        settings: settings,
      );

    case AddItemScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ActivityManagementBloc>(),
          child: AddItemScreen(
            activityType: settings.arguments,
          ),
        ),
        settings: settings,
      );

    case EditItemScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ActivityManagementBloc>(),
          child: EditItemScreen(
            activityType: settings.arguments,
          ),
        ),
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
