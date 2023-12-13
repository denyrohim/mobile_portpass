import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_progress.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_list.dart';

class TrackingActivityScreen extends StatelessWidget {
  TrackingActivityScreen({super.key, required this.activity});
  static const routeName = '/tracking-activity';

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
    return Scaffold(
      appBar: const AppBarCore(
        title: 'Lacak Aktivitas',
        isBackButton: true,
      ),
      body: BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.colorBackground,
            child: Center(
              child: ContainerCard(mediaHeight: 0.88, children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12, left: 12),
                  child: Text(
                    'Nama Aktivitas',
                    style: TextStyle(
                        fontFamily: Fonts.inter,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff315784)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Memasukkan Barang',
                    style: TextStyle(
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
                ActivityList(
                  activityProgress: _activityProgress,
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
