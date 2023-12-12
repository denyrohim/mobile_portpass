import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
// import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_search_bar.dart';
// import 'package:port_pass_app/src/employee_management/presentation/widgets/employee_confirmation_button.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/services/injection_container.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem(
    BuildContext context, {
    super.key,
    required this.isShowCheckBox,
    required this.index,
    required this.activities,
  });

  final bool isShowCheckBox;
  final int index;
  final List<Activity> activities;

  @override
  Flex build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        if (isShowCheckBox)
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
            margin: const EdgeInsets.only(bottom: 12),
            height: 160,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activities[index].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isShowCheckBox
                                      ? Colours.primaryColourDisabled
                                      : Colours.primaryColour,
                                  fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                          alignment: Alignment.center,
                          child: Container(
                              width: 88,
                              height: 24,
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                      color: Colours.itemCardBorderColour,
                                    ),
                                  ),
                                  color: Colours.secondaryColour,
                                  shadows: const [
                                    BoxShadow(
                                        color: Color(0x3f000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      MediaRes.acceptIcon,
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
                IgnorePointer(
                  ignoring: isShowCheckBox,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(BlocProvider(
                            create: (_) => sl<ActivityManagementBloc>(),
                            // child: EditEmployeeScreen(
                            //   employee: employees[index],
                            // ),
                          ));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: isShowCheckBox
                                      ? Colours.primaryColourDisabled
                                      : Colours.primaryColour,
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
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          context.push(BlocProvider(
                            create: (_) => sl<ActivityManagementBloc>(),
                            // child: EditEmployeeScreen(
                            //   employee: employees[index],
                            // ),
                          ));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: isShowCheckBox
                                      ? Colours.primaryColourDisabled
                                      : Colours.primaryColour,
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
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          context.push(BlocProvider(
                            create: (_) => sl<ActivityManagementBloc>(),
                            // child: EditEmployeeScreen(
                            //   employee: employees[index],
                            // ),
                          ));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: isShowCheckBox
                                      ? Colours.primaryColourDisabled
                                      : Colours.primaryColour,
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
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return BlocProvider(
                                create: (_) => sl<ActivityManagementBloc>(),
                                // child: ActivityConfirmationButton(
                                //   text: 'Yakin hapus?',
                                //   textStyle: const TextStyle(
                                //     fontSize: 20,
                                //     color: Colours.primaryColour,
                                //     fontWeight: FontWeight.w700,
                                //   ),
                                //   textButtonNegative: 'Batal',
                                //   textButtonPositive: 'Hapus',
                                //   colorTextButtonNegative:
                                //       Colours.primaryColour,
                                //   colorTextButtonPositive: Colours.errorColour,
                                //   employeesIds: [activity[index].id],
                                // ),
                              );
                            },
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: isShowCheckBox
                                      ? Colours.errorColourDisabled
                                      : Colours.errorColour,
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
