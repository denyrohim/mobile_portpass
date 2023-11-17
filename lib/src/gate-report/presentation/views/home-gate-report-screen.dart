import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';

import '../../../../core/res/fonts.dart';
import '../../../../core/res/media_res.dart';

class HomeGateReportScreen extends StatelessWidget {
  const HomeGateReportScreen({super.key});

  static const routeName = '/home-gate-report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.colorBackground,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MediaRes.logoPortPass,
                  height: 202,
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  height: 270,
                  width: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          height: 155,
                          width: 242,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: Text(
                              'Ingin Scan Activity?\nKlik Disini.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: Fonts.inter,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff315784),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 115),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          height: 104,
                          width: 104,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 115),
                        child: SvgPicture.asset(MediaRes.scanBold),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SvgPicture.asset(MediaRes.arrowsDown),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
