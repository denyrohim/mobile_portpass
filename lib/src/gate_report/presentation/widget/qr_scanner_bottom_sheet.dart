import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_widget.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/gate_report/presentation/views/detail_activity_screen.dart';

class QrScannerBottomSheet extends StatefulWidget {
  QrScannerBottomSheet(
      {super.key, required this.isSuccess, required this.cameraController});

  final bool isSuccess;
  final MobileScannerController cameraController;

  @override
  State<QrScannerBottomSheet> createState() => _QrScannerBottomSheetState();
}

class _QrScannerBottomSheetState extends State<QrScannerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    bool isSuccess = widget.isSuccess;
    final MobileScannerController cameraController = widget.cameraController;
    return BottomSheetWidget(
      height: 550,
      buttons: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.replay_rounded,
            size: 32,
            color: Colours.primaryColour,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
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
              height: 72,
              width: 72,
            ),
            SvgPicture.asset(
              MediaRes.scanLight,
              height: 32,
              width: 32,
            )
          ],
        ),
        IconButton(
          onPressed: () {
            final navigator = Navigator.of(context);
            // Navigator.of(context).pop();

            if (navigator.canPop()) {
              navigator.pop();
            }

            // Navigator.of(context).pushNamed(
            //   GateDetailActivityScreen.routeName,
            // );
            // Navigator.pushNamed(
            //     context, GateDetailActivityScreen.routeName);
            navigator.pushNamed(
              GateDetailActivityScreen.routeName,
            );
            cameraController.stop();
          },
          icon: const Icon(
            Icons.done,
            size: 32,
            color: Colours.primaryColour,
          ),
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Align(
            child: Text(
              'Scan QR Code',
              style: TextStyle(
                fontFamily: Fonts.inter,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xff315784),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
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
                height: 285,
                width: 256,
              ),
              Column(
                children: [
                  Container(
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
                    height: 156,
                    width: 144,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        isSuccess ? MediaRes.signalIcon : MediaRes.signalIcon2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    isSuccess ? 'Scan Berhasil' : 'Scan Gagal',
                    style: const TextStyle(
                      fontFamily: Fonts.inter,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff315784),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
