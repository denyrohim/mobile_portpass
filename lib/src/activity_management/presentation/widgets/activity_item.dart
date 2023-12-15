import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/edit_activity_screen.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/qr_code_activity_screen.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/tracking_activity_screen.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem(
    BuildContext context, {
    super.key,
    required this.isShowCheckBox,
    required this.index,
    required this.activities,
    required this.status,
  });

  final bool isShowCheckBox;
  final String status;
  final int index;
  final List<Activity> activities;

  @override
  Flex build(BuildContext context) {
    double buttonContainerHeight = 56;
    double buttonContainerWidth = 68;
    return Flex(
      direction: Axis.horizontal,
      children: [
        if (isShowCheckBox && status == 'Ditolak')
          GestureDetector(
            onTap: () {
              context.read<ActivityManagementBloc>().add(
                    UpdateCheckBoxActivityEvent(
                        activityId: index, activities: activities),
                  );
            },
            child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 500),
                decoration: const BoxDecoration(
                    color: Colours.primaryColour,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: const EdgeInsets.only(right: 10),
                height: 28,
                width: 28,
                child: activities[index].isChecked
                    ? Center(
                        child: SvgPicture.asset(MediaRes.checkIcon),
                      )
                    : null),
          ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            height: 180,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colours.itemCardBorderColour,
                    )),
                color: Colours.secondaryColour,
                shadows: const [
                  BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0)
                ]),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activities[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                color: isShowCheckBox
                                    ? Colours.primaryColourDisabled
                                    : Colours.primaryColour,
                                fontWeight: FontWeight.w700,
                                fontFamily: Fonts.inter,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              activities[index].type,
                              style: TextStyle(
                                fontSize: 12,
                                color: isShowCheckBox
                                    ? Colours.primaryColourDisabled
                                    : Colours.primaryColour,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              activities[index].date,
                              style: TextStyle(
                                fontSize: 12,
                                color: isShowCheckBox
                                    ? Colours.primaryColourDisabled
                                    : Colours.primaryColour,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: Container(
                              width: 100,
                              height: 24,
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(
                                        color: Colours.itemCardBorderColour,
                                      )),
                                  color: Colours.secondaryColour,
                                  shadows: const [
                                    BoxShadow(
                                        color: Color(0x3f000000),
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                        spreadRadius: 0)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      (activities[index].status == 'Diterima')
                                          ? MediaRes.acceptIcon
                                          : (activities[index].status ==
                                                  'Menunggu')
                                              ? MediaRes.waitingIcon
                                              : MediaRes.rejectIcon,
                                      width: 16,
                                      height: 16,
                                    ),
                                    const SizedBox(
                                        width:
                                            8), // Adjust the spacing between the icon and text as needed
                                    Text(
                                      activities[index].status,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isShowCheckBox
                                            ? Colours.primaryColourDisabled
                                            : Colours.primaryColour,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IgnorePointer(
                        ignoring: activities[index].status != 'Diterima',
                        child: GestureDetector(
                          onTap: () {
                            if (activities[index].status == 'Diterima') {
                              final navigator = Navigator.of(context);
                              navigator.pushNamed(
                                  TrackingActivityScreen.routeName,
                                  arguments: activities[index]);
                              debugPrint('Lacak');
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: buttonContainerWidth,
                                height: buttonContainerHeight,
                                decoration: BoxDecoration(
                                    color:
                                        activities[index].status == "Diterima"
                                            ? Colours.primaryColour
                                            : Colours.primaryColourDisabled,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      MediaRes.locationIcon,
                                      colorFilter: const ColorFilter.mode(
                                          Colours.secondaryColour,
                                          BlendMode.srcATop),
                                      width: 20,
                                      height: 20,
                                    ),
                                    const Text('Lacak',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IgnorePointer(
                        ignoring: activities[index].status != 'Diterima',
                        child: GestureDetector(
                          onTap: () {
                            if (activities[index].status == 'Diterima') {
                              final navigator = Navigator.of(context);
                              navigator.pushNamed(
                                  QRCodeActivityScreen.routeName,
                                  arguments: activities[index]);
                              debugPrint('QR Code');
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: buttonContainerWidth,
                                height: buttonContainerHeight,
                                decoration: BoxDecoration(
                                    color:
                                        activities[index].status == "Diterima"
                                            ? Colours.primaryColour
                                            : Colours.primaryColourDisabled,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      MediaRes.qrCodeIcon,
                                      width: 20,
                                      height: 20,
                                    ),
                                    const Text('QR Code',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IgnorePointer(
                        ignoring: activities[index].status == 'Diterima' ||
                            (isShowCheckBox && status == 'Ditolak'),
                        child: GestureDetector(
                          onTap: () {
                            if (activities[index].status != 'Diterima') {
                              context
                                  .read<ActivityProvider>()
                                  .initItemsEditActivity(
                                      activities[index].items);
                              final navigator = Navigator.of(context);
                              navigator.pushNamed(EditActivityScreen.routeName,
                                  arguments: activities[index]);
                            }
                            debugPrint('Edit');
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: buttonContainerWidth,
                                height: buttonContainerHeight,
                                decoration: BoxDecoration(
                                    color: isShowCheckBox && status == 'Ditolak'
                                        ? Colours.primaryColourDisabled
                                        : activities[index].status != 'Diterima'
                                            ? Colours.primaryColour
                                            : Colours.primaryColourDisabled,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      MediaRes.buttonEditIcons,
                                      colorFilter: const ColorFilter.mode(
                                          Colours.secondaryColour,
                                          BlendMode.srcATop),
                                      width: 20,
                                      height: 20,
                                    ),
                                    const Text('Edit',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IgnorePointer(
                        ignoring: activities[index].status == 'Diterima' ||
                            (isShowCheckBox && status == 'Ditolak'),
                        child: GestureDetector(
                          onTap: () {
                            if (activities[index].status == "Ditolak") {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  // return BlocProvider(
                                  //   create: (_) => sl<ActivityManagementBloc>(),
                                  //   // child: ActivityConfirmationButton(
                                  //   //   text: 'Yakin hapus?',
                                  //   //   textStyle: const TextStyle(
                                  //   //     fontSize: 20,
                                  //   //     color: Colours.primaryColour,
                                  //   //     fontWeight: FontWeight.w700,
                                  //   //   ),
                                  //   //   textButtonNegative: 'Batal',
                                  //   //   textButtonPositive: 'Hapus',
                                  //   //   colorTextButtonNegative:
                                  //   //       Colours.primaryColour,
                                  //   //   colorTextButtonPositive: Colours.errorColour,
                                  //   //   employeesIds: [activity[index].id],
                                  //   // ),
                                  // );
                                  return const Placeholder();
                                },
                              );
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: buttonContainerWidth,
                                height: buttonContainerHeight,
                                decoration: BoxDecoration(
                                    color: isShowCheckBox && status == 'Ditolak'
                                        ? Colours.errorColourDisabled
                                        : activities[index].status != "Diterima"
                                            ? Colours.errorColour
                                            : Colours.errorColourDisabled,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      MediaRes.buttonDeleteIcons,
                                      colorFilter: const ColorFilter.mode(
                                          Colours.secondaryColour,
                                          BlendMode.srcATop),
                                      width: 20,
                                      height: 20,
                                    ),
                                    const Text('Hapus',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
