import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardController>().getScreens(context.currentUser!.role);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<LocalUserModel>(
    //   stream: DashboardUtils.userDataStream,
    //   builder: (_, snapshot) {
    //     if (snapshot.hasData && snapshot.data is LocalUserModel) {
    //       context.read<UserProvider>().user = snapshot.data;
    //     }

    //   },
    // );

    return Consumer<DashboardController>(builder: (_, controller, __) {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex,
          children: controller.screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          elevation: 8,
          onTap: controller.changeIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                color: controller.currentIndex == 0
                    ? Colours.primaryColour
                    : Colors.grey,
                size: 32,
              ),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex == 1
                    ? Icons.add_circle
                    : Icons.add_circle_outline,
                color: controller.currentIndex == 1
                    ? Colours.primaryColour
                    : Colors.grey,
                size: 32,
              ),
              label: 'Add Employee',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex == 2
                    ? Icons.person_pin_rounded
                    : Icons.person_pin_outlined,
                color: controller.currentIndex == 2
                    ? Colours.primaryColour
                    : Colors.grey,
                size: 32,
              ),
              label: 'Profile',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      );
    });
  }
}
