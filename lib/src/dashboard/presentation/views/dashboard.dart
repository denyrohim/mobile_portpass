import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/media_res.dart';
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
              icon: SvgPicture.asset(
                controller.currentIndex == 0
                    ? MediaRes.homeBold
                    : MediaRes.homeLight,
                height: 32,
                width: 32,
              ),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            if (context.currentUser!.role == 'security')
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.currentIndex == 1
                      ? MediaRes.scanBold
                      : MediaRes.scanLight,
                  height: 32,
                  width: 32,
                ),
                label: 'Scan',
                backgroundColor: Colors.white,
              )
            else
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.currentIndex == 1
                      ? MediaRes.addBold
                      : MediaRes.addLight,
                  height: 32,
                  width: 32,
                ),
                label: 'Add',
                backgroundColor: Colors.white,
              ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                controller.currentIndex == 2
                    ? MediaRes.profileBold
                    : MediaRes.profileLight,
                height: 32,
                width: 32,
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
