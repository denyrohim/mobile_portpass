import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_widget.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    required this.dateController
  });

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      height: 0.7,
      buttonsBottomPosition: 10,
      buttons: [
        RoundedButton(
          onPressed: () {
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
              'Pilih Tanggal',
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2024),
                onDateChanged: (date) {
                  dateController.text = date.toString().split(" ")[0];
                },
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
