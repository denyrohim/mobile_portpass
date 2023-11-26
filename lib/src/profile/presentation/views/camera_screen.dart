import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primaryColour,
      ),
      body: GradientBackground(
        image: MediaRes.colorBackground,
        child: ContainerCard(
          header: SizedBox(
            height: 7,
            width: 64,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colours.primaryColour,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          mediaHeight: 0.3,
          children: [
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ambil Foto",
                  style: TextStyle(
                    color: Colours.primaryColour,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontFamily: Fonts.inter,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 64,
                        height: 64,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent,
                        ),
                        child: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(
                            'assets/icons/retake_icon.svg',
                          ),
                        )),
                    Container(
                        width: 64,
                        height: 64,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: Colours.primaryColour,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          color: Colours.secondaryColour,
                        ),
                        child: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(
                            'assets/icons/camera_icon.svg',
                          ),
                        )),
                    Container(
                        width: 64,
                        height: 64,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent,
                        ),
                        child: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(
                            'assets/icons/tick_icon.svg',
                          ),
                        )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
