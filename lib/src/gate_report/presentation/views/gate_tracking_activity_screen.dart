import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/auth/presentation/views/splash_screen.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity_progress.dart';
import 'package:port_pass_app/src/gate_report/presentation/bloc/gate_report_bloc.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/gate_activity_list.dart';

class GateTrackingActivityScreen extends StatelessWidget {
  GateTrackingActivityScreen({super.key, required this.activity});
  static const routeName = '/gate-tracking-activity';

  final dynamic activity;

  final List<ActivityProgress> _activityProgress = [
    const ActivityProgress(
      name: 'Activity Dibuat',
      date: '00:00, DD/MM/YYYY',
      time: 'asdfas',
      status: 'true',
    ),
    const ActivityProgress(
      name: 'Activity Disetujui',
      date: '00:00, DD/MM/YYYY',
      time: 'asdfas',
      status: 'true',
    ),
    const ActivityProgress(
      name: 'Lulus Keamanan Pabrik II',
      date: '00:00, DD/MM/YYYY',
      time: 'asdfas',
      status: 'true',
    ),
    const ActivityProgress(
      name: 'Lulus Keamanan Pelabuhan',
      date: '00:00, DD/MM/YYYY',
      time: 'asdfas',
      status: 'true',
    ),
    const ActivityProgress(
      name: 'Lulus Pengawas Bongkar Muat',
      date: '00:00, DD/MM/YYYY',
      time: 'asdfas',
      status: 'false',
    ),
    const ActivityProgress(
      name: 'Selesai',
      date: '00:00, DD/MM/YYYY',
      time: 'asdfas',
      status: 'false',
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
            "Lacak Aktivitas",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colours.secondaryColour,
            ),
          ),
        ),
        body: BlocConsumer<GateReportBloc, GateReportState>(
          listener: (context, state) {},
          builder: (context, state) {
            return GradientBackground(
              image: MediaRes.colorBackground,
              child: Center(
                child: ContainerCard(mediaHeight: 0.88, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 12),
                    child: Text(
                      activity.name,
                      style: const TextStyle(
                          fontFamily: Fonts.inter,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff315784)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      activity.type,
                      style: const TextStyle(
                          fontFamily: Fonts.inter,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff315784)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: SizedBox(
                      height: 1,
                      width: double.infinity,
                      child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xff315784))),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Progress Aktivitas',
                      style: TextStyle(
                          fontFamily: Fonts.inter,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff315784)),
                    ),
                  ),
                  GateActivityList(
                    activityProgress: _activityProgress,
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
