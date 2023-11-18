import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';

import '../../../../core/res/colours.dart';
import '../../../../core/res/fonts.dart';
import '../../../../core/res/media_res.dart';

class ScanQRCodeScreen extends StatefulWidget {
  const ScanQRCodeScreen({super.key});

  static const routeName = '/scan-qr-code-screen';

  @override
  State<ScanQRCodeScreen> createState() => _ScanQRCodeScreenState();
}

class _ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
  MobileScannerController scannerController = MobileScannerController();
  bool isScanCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Expanded(
              child: MobileScanner(
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');
                  }
                  if (barcodes.isNotEmpty) {
                    isScanCompleted = true;
                  }
                },
              ),
            ),
            ContainerCard(
              mediaHeight: 0.28,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              MediaRes.scanBold,
                              height: 32,
                              width: 32,
                            )
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
            // scan berhasil
            Visibility(
              visible: isScanCompleted,
              child: ContainerCard(
                mediaHeight: 0.65,
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
                  Column(
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
                                  child: SvgPicture.asset(MediaRes.signalIcon),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Scan Berhasil',
                                style: TextStyle(
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
                                MediaRes.scanBold,
                                height: 32,
                                width: 32,
                              )
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
                  ),
                ],
              ),
            ),
            // scan gagal
            Visibility(
              visible: isScanCompleted,
              child: ContainerCard(
                mediaHeight: 0.65,
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
                  Column(
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
                                  child: SvgPicture.asset(MediaRes.signalIcon2),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Scan Gagal',
                                style: TextStyle(
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
                                MediaRes.scanBold,
                                height: 32,
                                width: 32,
                              )
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
