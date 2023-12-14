import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_widget.dart';
import 'package:port_pass_app/core/common/widgets/dialog_confirmation.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';

class ActivityConfirmationButton extends StatefulWidget {
  const ActivityConfirmationButton({
    super.key,
    required this.text,
    this.textStyle,
    required this.textButtonPositive,
    this.colorTextButtonPositive,
    required this.textButtonNegative,
    this.colorTextButtonNegative,
    required this.activitiesIds,
  });

  final List<int> activitiesIds;
  final String text;
  final TextStyle? textStyle;
  final String textButtonPositive;
  final Color? colorTextButtonPositive;
  final String textButtonNegative;
  final Color? colorTextButtonNegative;

  @override
  State<ActivityConfirmationButton> createState() =>
      _ActivityConfirmationButtonState();
}

class _ActivityConfirmationButtonState
    extends State<ActivityConfirmationButton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is ActivityManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataLoaded) {
          context.read<ActivityProvider>().initActivities(state.activities);
          context.read<ActivityProvider>().setShowChecked(false);
        } else if (state is DataDeleted) {
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          }
          showDialog(
            context: context,
            builder: (context) {
              return DialogConfirmation(
                title: 'Berhasil dihapus',
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      MediaRes.buttonDeleteIcons,
                      colorFilter: const ColorFilter.mode(
                          Colours.primaryColour, BlendMode.srcIn),
                      width: 100,
                      height: 100,
                    ),
                    SvgPicture.asset(
                      MediaRes.checkIcon,
                      colorFilter: const ColorFilter.mode(
                          Colours.secondaryColour, BlendMode.srcIn),
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
              );
            },
          );
          context
              .read<ActivityManagementBloc>()
              .add(const GetActivitiesEvent());
        }
      },
      builder: (context, state) {
        return BottomSheetWidget(
          height: 200,
          buttonsBottomPosition: 20,
          buttons: [
            RoundedButton(
              onPressed: () {
                final navigator = Navigator.of(context);
                if (navigator.canPop()) {
                  navigator.pop();
                }
              },
              text: widget.textButtonNegative,
              backgroundColor: widget.colorTextButtonNegative,
            ),
            RoundedButton(
              onPressed: () {
                context.read<ActivityManagementBloc>().add(
                      DeleteActivitiesEvent(
                          activitiesIds: widget.activitiesIds),
                    );
              },
              text: widget.textButtonPositive,
              backgroundColor: widget.colorTextButtonPositive,
            ),
          ],
          child: Center(
            child: SizedBox(
              width: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: widget.textStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
