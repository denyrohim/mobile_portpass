import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/tab_navigator.dart';
import 'package:port_pass_app/core/common/views/page_under_construction.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/services/injection_container.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/list_activity_screen.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';
import 'package:port_pass_app/src/employee_management/presentation/views/add_employee_screen.dart';
import 'package:port_pass_app/src/employee_management/presentation/views/list_employee_screen.dart';
import 'package:port_pass_app/src/gate_report/presentation/views/home_gate_report_screen.dart';
import 'package:port_pass_app/src/profile/presentation/views/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/views/persistent_view.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  // I want to get role user from ContextExtensions on BuildContext

  late List<Widget> _screens = [];

  List<Widget> get screens => _screens;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void getScreens(String role) {
    if (role == 'employee') {
      _screens = [
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: BlocProvider(
                      create: (_) => sl<EmployeeManagementBloc>(),
                      child: const ListEmployeeScreen(),
                    ),
                  ),
                ),
            child: const PersistentView()),
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: BlocProvider(
                      create: (_) => sl<EmployeeManagementBloc>(),
                      child: const AddEmployeeScreen(),
                    ),
                  ),
                ),
            child: const PersistentView()),
      ];
    } else if (role == 'agent') {
      _screens = [
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: BlocProvider(
                      create: (_) => sl<ActivityManagementBloc>(),
                      child: const ListActivityScreen(),
                    ),
                  ),
                ),
            child: const PersistentView()),
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colours.primaryColour,
                      ),
                      backgroundColor: Colors.transparent,
                      body: const GradientBackground(
                        image: MediaRes.colorBackground,
                        child: PageUnderConstruction(),
                      ),
                    ),
                  ),
                ),
            child: const PersistentView()),
      ];
    } else if (role == 'security') {
      _screens = [
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: const HomeGateReportScreen(),
                  ),
                ),
            child: const PersistentView()),
        ChangeNotifierProvider(
            create: (_) => TabNavigator(
                  TabItem(
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colours.primaryColour,
                      ),
                      backgroundColor: Colors.transparent,
                      body: const GradientBackground(
                        image: MediaRes.colorBackground,
                        child: PageUnderConstruction(),
                      ),
                    ),
                  ),
                ),
            child: const PersistentView()),
      ];
    }

    screens.add(
      ChangeNotifierProvider(
          create: (_) => TabNavigator(
                TabItem(
                  child: BlocProvider(
                    create: (_) => sl<AuthBloc>(),
                    child: const ProfileScreen(),
                  ),
                ),
              ),
          child: const PersistentView()),
    );
  }

  void changeIndex(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
