import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity_progress.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({
    super.key,
    required this.activityProgress,
  });

  //final ActivityProgress activityProgress;
  final List<ActivityProgress> activityProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(activityProgress.length, (index) {
        final progress = activityProgress[index];
        const changeColor = Color(0xff315784);
        const changeFont = FontWeight.w700;
        final checkAtas = index > 0
            ? const LineStyle(
                color: Color(0xff315784),
                thickness: 1,
              )
            : const LineStyle(
                color: Color(0xff92A6BE),
                thickness: 1,
              );
        final checkBawah = index < activityProgress.length - 1
            ? const LineStyle(
                color: Color(0xff315784),
                thickness: 1,
              )
            : const LineStyle(
                color: Color(0xff92A6BE),
                thickness: 1,
              );

        if (index == 0) {
          return SizedBox(
            width: 350,
            height: 75,
            child: TimelineTile(
              endChild: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        progress.name,
                        style: const TextStyle(
                          fontFamily: Fonts.inter,
                          fontSize: 16,
                          fontWeight: changeFont,
                          color: changeColor,
                        ),
                      ),
                      const SizedBox(
                          height: 1), // Add some space between the two texts
                      Text(DateFormat('yyyy-MM-dd').format(progress.dateTime),
                          style: const TextStyle(
                            fontFamily: Fonts.inter,
                            fontSize: 16,
                            fontWeight: changeFont,
                            color: changeColor,
                          )), // bakal diganti dengan data ril
                    ],
                  ),
                ),
              ),
              isFirst: true,
              afterLineStyle: checkBawah,
              lineXY: 0.1,
              alignment: TimelineAlign.manual,
              indicatorStyle: const IndicatorStyle(
                color: changeColor,
                width: 10,
              ),
            ),
          );
        }
        if (index > 0 && index < activityProgress.length - 1) {
          return SizedBox(
            width: 350,
            height: 75,
            child: TimelineTile(
              endChild: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        progress.name,
                        style: const TextStyle(
                          fontFamily: Fonts.inter,
                          fontSize: 16,
                          fontWeight: changeFont,
                          color: changeColor,
                        ),
                      ),
                      const SizedBox(
                          height: 1), // Add some space between the two texts
                      Text(DateFormat('yyyy-MM-dd').format(progress.dateTime),
                          style: const TextStyle(
                            fontFamily: Fonts.inter,
                            fontSize: 16,
                            fontWeight: changeFont,
                            color: changeColor,
                          )), // bakal diganti dengan data ril
                    ],
                  ),
                ),
              ),
              lineXY: 0.1,
              alignment: TimelineAlign.manual,
              afterLineStyle: checkBawah,
              beforeLineStyle: checkAtas,
              indicatorStyle: const IndicatorStyle(
                color: changeColor,
                width: 10,
              ),
            ),
          );
        }

        if (index == activityProgress.length - 1) {
          return SizedBox(
            width: 350,
            height: 75,
            child: TimelineTile(
              endChild: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        progress.name,
                        style: const TextStyle(
                          fontFamily: Fonts.inter,
                          fontSize: 16,
                          fontWeight: changeFont,
                          color: changeColor,
                        ),
                      ),
                      const SizedBox(
                          height: 1), // Add some space between the two texts
                      Text(DateFormat('yyyy-MM-dd').format(progress.dateTime),
                          style: const TextStyle(
                            fontFamily: Fonts.inter,
                            fontSize: 16,
                            fontWeight: changeFont,
                            color: changeColor,
                          )), // bakal diganti dengan data ril
                    ],
                  ),
                ),
              ),
              isLast: true,
              lineXY: 0.1,
              alignment: TimelineAlign.manual,
              beforeLineStyle: checkAtas,
              indicatorStyle: const IndicatorStyle(
                color: changeColor,
                width: 10,
              ),
            ),
          );
        } else {
          return const SizedBox(
            width: 0,
            height: 0,
          );
        }
      }),
    );
  }
}
