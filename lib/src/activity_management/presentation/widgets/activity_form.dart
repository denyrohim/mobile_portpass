import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/widgets/i_dropdown.dart';
import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/calendar_widget_activity.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/hour_widget_activity.dart';

class ActivityForm extends StatefulWidget {
  const ActivityForm({
    super.key,
    required this.nameController,
    required this.shipNameController,
    required this.activityTypeController,
    required this.activityDateController,
    required this.activityHourController,
    required this.formKey,
  });

  final TextEditingController nameController;
  final TextEditingController shipNameController;
  final TextEditingController activityTypeController;
  final TextEditingController activityDateController;
  final TextEditingController activityHourController;
  final GlobalKey<FormState> formKey;

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nama Aktivitas',
            style: TextStyle(
              color: Colours.primaryColour,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          IFields(
            controller: widget.nameController,
            hintText: 'Aktivitas',
            hintStyle: const TextStyle(
              color: Colours.primaryColour,
              fontFamily: Fonts.inter,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nama Kapal',
            style: TextStyle(
              color: Colours.primaryColour,
              fontSize: 16,
              fontFamily: Fonts.inter,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          IFields(
            controller: widget.shipNameController,
            hintText: 'Kapal',
            hintStyle: const TextStyle(
              color: Colours.primaryColour,
              fontFamily: Fonts.inter,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Jenis Kegiatan',
            style: TextStyle(
              color: Colours.primaryColour,
              fontSize: 16,
              fontFamily: Fonts.inter,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          IDropdown(
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colours.primaryColour,
              ),
              controller: widget.activityTypeController,
              hintText: 'Jenis Kegiatan',
              hintStyle: const TextStyle(
                color: Colours.primaryColour,
                fontFamily: Fonts.inter,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              fillColor: Colours.secondaryColour,
              items: const [
                DropdownMenuItem(
                  value: 'Memasukkan Barang',
                  child: Text(
                    'Memasukkan Barang',
                    style: TextStyle(
                      color: Colours.primaryColour,
                      fontFamily: Fonts.inter,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Mengeluarkan Barang',
                  child: Text(
                    'Mengeluarkan Barang',
                    style: TextStyle(
                      color: Colours.primaryColour,
                      fontFamily: Fonts.inter,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ]),
          const SizedBox(height: 12),
          const Text(
            'Tanggal Kegiatan',
            style: TextStyle(
              color: Colours.primaryColour,
              fontSize: 16,
              fontFamily: Fonts.inter,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          IFields(
            controller: widget.activityDateController,
            hintText: 'DD/MM/YYYY',
            hintStyle: const TextStyle(
              color: Colours.primaryColour,
              fontFamily: Fonts.inter,
              fontSize: 16,
            ),
            keyboardType: TextInputType.datetime,
            overrideValidator: false,
            suffixIcon: const Icon(
              Icons.calendar_today,
              color: Colours.primaryColour,
            ),
            readOnly: true,
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return CalendarWidgetActivity(
                    dateController: widget.activityDateController,
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'Jam Kegiatan',
            style: TextStyle(
              color: Colours.primaryColour,
              fontSize: 16,
              fontFamily: Fonts.inter,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          IFields(
            controller: widget.activityHourController,
            hintText: '00:00',
            hintStyle: const TextStyle(
              color: Colours.primaryColour,
              fontFamily: Fonts.inter,
              fontSize: 16,
            ),
            keyboardType: TextInputType.datetime,
            overrideValidator: false,
            suffixIcon: Transform.scale(
              scale: 0.5,
              child: SvgPicture.asset(
                MediaRes.hourIcon,
              ),
            ),
            readOnly: true,
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return HourWidgetActivity(
                    hourController: widget.activityHourController,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
