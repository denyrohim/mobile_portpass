import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';

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
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    MediaRes.logoPortPass,
                    height: 180,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colours.secondaryColour,
                    ),
                    height: 270,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          context.currentUser!.location ?? 'Lokasi belum ada',
                          style: const TextStyle(
                            fontFamily: Fonts.inter,
                            fontWeight: FontWeight.w700,
                            color: Colours.primaryColour,
                            fontSize: 20,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colours.secondaryColour,
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
                                      color: Colours.primaryColour,
                                      fontSize: 16,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SvgPicture.asset(MediaRes.arrowsDown),
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
