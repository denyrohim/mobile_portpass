import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key, required this.child, this.buttons});

  final Widget child;
  final List<Widget>? buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 64,
                height: 8,
                decoration: BoxDecoration(
                  color: Colours.primaryColour,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          child,
          Positioned(
            bottom: 62,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttons ?? [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
