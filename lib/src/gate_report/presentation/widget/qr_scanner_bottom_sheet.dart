import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port_pass_app/core/common/app/providers/report_provider.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_widget.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/gate_report/presentation/bloc/gate_report_bloc.dart';
import 'package:port_pass_app/src/gate_report/presentation/views/gate_detail_activity_screen.dart';

class QrScannerBottomSheet extends StatefulWidget {
  const QrScannerBottomSheet({
    super.key,
    required this.isSuccess,
    required this.cameraController,
  });

  final bool isSuccess;
  final MobileScannerController cameraController;

  @override
  State<QrScannerBottomSheet> createState() => _QrScannerBottomSheetState();
}

class _QrScannerBottomSheetState extends State<QrScannerBottomSheet> {
  int? activityId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSuccess = widget.isSuccess;
    final MobileScannerController cameraController = widget.cameraController;
    return BlocConsumer<GateReportBloc, GateReportState>(
      listener: (context, state) async {
        if (state is GateReportError) {
          debugPrint('error: ${state.message}');
        } else if (state is ActivityLoaded) {
          context.read<ReportProvider>().initActivity(state.activity);
          final navigator = Navigator.of(context);

          await cameraController.stop();

          if (navigator.canPop()) {
            navigator.pop();
          }
          navigator.pushNamed(
            GateDetailActivityScreen.routeName,
          );
        }
      },
      builder: (context, state) {
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
                activityId = context.read<ReportProvider>().activityId;
                context.read<GateReportBloc>().add(
                      GetActivityEvent(activityId: activityId!),
                    );
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
                    padding: const EdgeInsets.all(20),
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
                    child: Column(
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
                              isSuccess && state is! GateReportError
                                  ? MediaRes.signalIcon
                                  : MediaRes.signalIcon2,
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
                        if (state is GateReportError)
                          Text(
                            state.message,
                            style: const TextStyle(
                              fontFamily: Fonts.inter,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colours.errorColour,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
