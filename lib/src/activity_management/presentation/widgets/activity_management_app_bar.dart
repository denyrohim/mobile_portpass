import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/widgets/pop_up_item.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/services/injection_container.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_confirmation_button.dart';

class ActivityManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ActivityManagementAppBar({
    super.key,
    required this.count,
    required this.activityProvider,
    required this.statusController,
    required this.activitiesDefault,
  });

  final int count;
  final ActivityProvider activityProvider;
  final TextEditingController statusController;
  final List<Activity> activitiesDefault;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colours.primaryColour,
      foregroundColor: Colours.secondaryColour,
      title: const Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Daftar Aktivitas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      actions: [
        (activityProvider.isShowChecked && statusController.text == 'Ditolak')
            ? Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Text(
                      '${activityProvider.countActivitiesChecked} Terpilih',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: GestureDetector(
                      onTap: () {
                        debugPrint('delete di klik');
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return BlocProvider(
                              create: (_) => sl<ActivityManagementBloc>(),
                              child: ActivityConfirmationButton(
                                text: 'Yakin hapus semua daftar?',
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colours.primaryColour,
                                  fontWeight: FontWeight.w700,
                                ),
                                textButtonNegative: 'Batal',
                                textButtonPositive: 'Hapus',
                                colorTextButtonNegative: Colours.primaryColour,
                                colorTextButtonPositive: Colours.errorColour,
                                activitiesIds:
                                    activityProvider.idCheckedActivities,
                              ),
                            );
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: Colours.errorColour,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SvgPicture.asset(
                            MediaRes.buttonDeleteIcons,
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        context.read<ActivityManagementBloc>().add(
                            CancelCheckBoxActivitiesEvent(
                                activities: activityProvider.activities!));
                        activityProvider.setShowChecked(false);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: Colours.primaryColour,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          const Icon(
                            Icons.close_rounded,
                            color: Colours.secondaryColour,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Text(
                    '$count Daftar',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.secondaryColour),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: PopupMenuButton(
                      color: Colours.secondaryColourDisabled,
                      offset: const Offset(0, 50),
                      icon: SvgPicture.asset(MediaRes.moreIcons),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      itemBuilder: (_) => [
                        if (statusController.text != 'Ditolak') ...[
                          PopupMenuItem(
                            value: 1,
                            child: const PopUpItem(
                              title: 'Diterima',
                            ),
                            onTap: () {
                              statusController.text = 'Diterima';
                              context.read<ActivityManagementBloc>().add(
                                    ChangeStatusActivitiesEvent(
                                      activities: activitiesDefault,
                                      status: statusController.text,
                                    ),
                                  );
                            },
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: const PopUpItem(
                              title: 'Menunggu',
                            ),
                            onTap: () {
                              statusController.text = 'Menunggu';
                              context.read<ActivityManagementBloc>().add(
                                    ChangeStatusActivitiesEvent(
                                      activities: activitiesDefault,
                                      status: statusController.text,
                                    ),
                                  );
                            },
                          ),
                        ] else ...[
                          PopupMenuItem(
                            value: 1,
                            child: const PopUpItem(
                              title: 'Pilih',
                            ),
                            onTap: () {
                              activityProvider.setShowChecked(true);
                            },
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: const PopUpItem(
                              title: 'Pilih Semua',
                            ),
                            onTap: () {
                              debugPrint("disini");
                              context.read<ActivityManagementBloc>().add(
                                    SelectAllActivitiesEvent(
                                      activities: activityProvider.activities!,
                                    ),
                                  );
                              debugPrint("masuk");
                              activityProvider.setShowChecked(true);
                            },
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
