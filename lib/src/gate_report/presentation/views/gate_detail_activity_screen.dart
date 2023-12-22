import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/report_provider.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/auth/presentation/views/splash_screen.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/presentation/bloc/gate_report_bloc.dart';
import 'package:port_pass_app/src/gate_report/presentation/views/add_report_screen.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/item_card.dart';

class GateDetailActivityScreen extends StatefulWidget {
  const GateDetailActivityScreen({super.key});

  static const routeName = '/gate-detail-activity';

  @override
  State<GateDetailActivityScreen> createState() =>
      _GateDetailActivityScreenState();
}

class _GateDetailActivityScreenState extends State<GateDetailActivityScreen> {
  late Activity activity;

  @override
  void initState() {
    activity = context.read<ReportProvider>().activity!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GateReportBloc, GateReportState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (_) {
            final navigator = Navigator.of(context);
            navigator.pushReplacementNamed(SplashScreen.routeName);
          },
          child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colours.primaryColour,
              leading: IconButton(
                color: Colours.secondaryColour,
                iconSize: 30,
                icon: Icon(
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? Icons.arrow_back_ios_new
                      : Icons.arrow_back,
                ),
                onPressed: () {
                  final navigator = Navigator.of(context);
                  navigator.pop;
                  navigator.pushReplacementNamed(SplashScreen.routeName);
                },
              ),
              title: const Text(
                "Detail Aktivitas",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colours.secondaryColour,
                ),
              ),
            ),
            body: GradientBackground(
              image: MediaRes.colorBackground,
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 48, right: 48),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Text("Nama Aktivitas",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        ": ${activity.name}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Text("Nama Kapal",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        ": ${activity.shipName}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Text("Jenis Kegiatan",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        ": ${activity.type}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Text("Rute Kegiatan",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        ": ${activity.route ?? "-"}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Text("Tanggal Dibuat",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(": ${activity.date}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Text("Status",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 5,
                                        children: [
                                          const Text(":",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                          SvgPicture.asset(
                                            activity.status == "Accepted"
                                                ? MediaRes.acceptIcon
                                                : activity.type == "Cancelled"
                                                    ? MediaRes.rejectIcon
                                                    : MediaRes.waitingIcon,
                                          ),
                                          Text(activity.status,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ContainerCard(
                      mediaHeight: 0.58,
                      header: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFF315784),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RoundedButton(
                                text: "Lanjutkan",
                                horizontalPadding: 10,
                                verticalPadding: 6,
                                backgroundColor: Colours.primaryColour,
                                foregroundColor: Colours.secondaryColour,
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                iconPositionFront: false,
                                onPressed: () {
                                  final navigator = Navigator.of(context);
                                  navigator.pushNamed(
                                    AddReportScreen.routeName,
                                    arguments: activity,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Daftar Barang",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colours.primaryColour,
                                    fontFamily: Fonts.inter,
                                  ),
                                ),
                                Text(
                                  "5 Daftar",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colours.primaryColour,
                                    fontFamily: Fonts.inter,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 80),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 6, left: 6, right: 6),
                              decoration: const BoxDecoration(
                                color: Colours.secondaryColour,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.46,
                              child: Stack(
                                children: [
                                  ListView.builder(
                                      itemCount: activity.items.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ItemCard(
                                            item: activity.items[index],
                                            index: index,
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
