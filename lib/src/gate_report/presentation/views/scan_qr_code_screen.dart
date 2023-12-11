import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/nested_back_button.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/gate_report/presentation/bloc/gate_report_bloc.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/qr_scanner_bottom_sheet.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/qr_scanner_overlay.dart';

import '../../../../core/res/colours.dart';
import '../../../../core/res/fonts.dart';
import '../../../../core/res/media_res.dart';

class ScanQRCodeScreen extends StatefulWidget {
  const ScanQRCodeScreen({super.key});

  static const routeName = '/scan-qr-code';

  @override
  State<ScanQRCodeScreen> createState() => _ScanQRCodeScreenState();
}

class _ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanCompleted = false;
  bool isCanScan = false;
  bool isButtonScanPressed = false;
  late bool isSuccess;
  List<Barcode> barcodes = [];

  void _scanBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return QrScannerBottomSheet(
          isSuccess: isSuccess,
          cameraController: cameraController,
        );
      },
    );
  }

  @override
  void initState() {
    cameraController.stop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GateReportBloc, GateReportState>(
      listener: (context, state) {
        if (state is GateReportError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is ScanSuccess) {
          setState(() {
            isCanScan = false;
            isSuccess = true;
            isButtonScanPressed = false;
          });
          _scanBottomSheet();
        } else if (state is ScanFailed) {
          setState(() {
            isCanScan = false;
            isSuccess = false;
            isButtonScanPressed = false;
          });
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            // scrolledUnderElevation: 0,
            // backgroundColor: Colours.primaryColour,
            leading: NestedBackButton(
              onPressed: () {
                context.dashboardController.changeIndex(0);
              },
            ),
            title: const Text(
              "Scan",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colours.secondaryColour,
              ),
            ),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                MobileScanner(
                  controller: MobileScannerController(),
                  onDetect: (capture) {
                    if (isCanScan) {
                      debugPrint('Ahhh Masuk');
                      barcodes = capture.barcodes;
                      context.read<GateReportBloc>().add(
                            ScanQrActivityEvent(barcodes: barcodes),
                          );
                    }
                  },
                ),
                QRScannerOverlay(
                  overlayColour: Colors.black.withOpacity(0.5),
                ),
                ContainerCard(
                  mediaHeight: 0.27,
                  header: Container(
                    width: 72,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colours.primaryColour,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        const Align(
                          child: Text(
                            'Scan Sekarang',
                            style: TextStyle(
                              fontFamily: Fonts.inter,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff315784),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.replay_rounded,
                              size: 32,
                              color: Color(0x31578480),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isCanScan = true;
                                      isButtonScanPressed = true;
                                    });
                                    debugPrint('Mulai ga Kontol: $isCanScan');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: const CircleBorder(),
                                    elevation: 2,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              blurRadius: 4,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        height: 72,
                                        width: 72,
                                      ),
                                      SvgPicture.asset(
                                        isButtonScanPressed
                                            ? MediaRes.scanLight
                                            : MediaRes.scanBold,
                                        height: 32,
                                        width: 32,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.done,
                              size: 32,
                              color: Color(0x31578480),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
