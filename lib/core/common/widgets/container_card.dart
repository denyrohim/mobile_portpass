import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard(
      {super.key, this.backgroundColor = Colors.white, required this.child});

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.only(top: 120),
      padding: const EdgeInsets.all(10),
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 72,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colours.primaryColour,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: child,
          ),
        ],
      ),
    );
  }
}
