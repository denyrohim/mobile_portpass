import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_widget.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/common/widgets/tile_hour.dart';
import 'package:port_pass_app/core/common/widgets/tile_minute.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';

class HourWidgetActivity extends StatefulWidget {
  const HourWidgetActivity({super.key, required this.hourController});

  final TextEditingController hourController;

  static const routeName = '/hour-widget-activity';

  @override
  State<HourWidgetActivity> createState() => _HourWidgetActivityState();
}

class _HourWidgetActivityState extends State<HourWidgetActivity> {
  int hour = 0;
  int minute = 0;
  String get time =>
      '${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}';

  @override
  void initState() {
    if (widget.hourController.text != '') {
      hour = int.parse(widget.hourController.text.split(':').first);
      minute = int.parse(widget.hourController.text.split(':').last);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      height: 520,
      buttonsBottomPosition: 20,
      buttons: [
        RoundedButton(
          onPressed: () {
            widget.hourController.text = time;
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            }
          },
          text: 'Simpan',
          backgroundColor: Colours.primaryColour,
        ),
      ],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pilih Jam',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour,
                  fontFamily: Fonts.inter),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 320,
                width: 350,
                decoration: BoxDecoration(
                  color: Colours.secondaryColour,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ListWheelScrollView.useDelegate(
                        overAndUnderCenterOpacity: 0.5,
                        controller:
                            FixedExtentScrollController(initialItem: hour),
                        onSelectedItemChanged: (value) {
                          hour = value;
                          widget.hourController.text = time;
                        },
                        itemExtent: 80,
                        perspective: 0.005,
                        physics: const FixedExtentScrollPhysics(),
                        diameterRatio: 1.2,
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) => TileHour(
                            hour: index,
                          ),
                          childCount: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      ':',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 100,
                      child: ListWheelScrollView.useDelegate(
                        overAndUnderCenterOpacity: 0.5,
                        controller:
                            FixedExtentScrollController(initialItem: minute),
                        onSelectedItemChanged: (value) {
                          minute = value;
                          widget.hourController.text = time;
                        },
                        itemExtent: 80,
                        perspective: 0.005,
                        physics: const FixedExtentScrollPhysics(),
                        diameterRatio: 1.2,
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) => TileMinute(
                            minute: index,
                          ),
                          childCount: 60,
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
