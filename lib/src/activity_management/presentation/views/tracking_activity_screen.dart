import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_progress.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_list.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_management_app_bar.dart';

class TrackingActivityScreen extends StatelessWidget {
  TrackingActivityScreen({super.key});
  static const routeName = '/tracking-activity';
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
      appBar: const ActivityManagementAppBar(
        title: 'Lacak Aktivitas',
      ),
      body: GradientBackground(
        image: MediaRes.colorBackground,
        child: Center(
          child: ContainerCard(mediaHeight: 0.88, children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Nama Aktivitas',
                style: TextStyle(
                    fontFamily: Fonts.inter,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff315784)),
              ),
            ),
            const Text(
              'Memasukkan Barang',
              style: TextStyle(
                  fontFamily: Fonts.inter,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff315784)),
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
            const Text(
              'Progress Aktivitas',
              style: TextStyle(
                  fontFamily: Fonts.inter,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff315784)),
            ),
            ActivityList(
              activityProgress: _activityProgress,
            ),
          ]),
        ),
      ),
    );
  }
}
