import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_list.dart';

class TrackingActivityScreen extends StatelessWidget {
  const TrackingActivityScreen({super.key, required this.activity});
  static const routeName = '/tracking-activity';

  final dynamic activity;

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
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  child: Text(
                    activity.name,
                    style: const TextStyle(
                      fontFamily: Fonts.inter,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff315784),
                    ),
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
                activity.activityProgress.isEmpty
                    ? SizedBox(
                        height: context.height * 0.6,
                        child: const Center(
                          child: Text(
                            'Tidak ada data',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colours.primaryColour),
                          ),
                        ),
                      )
                    : ActivityList(
                        activityProgress: activity.activityProgress,
                      ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
