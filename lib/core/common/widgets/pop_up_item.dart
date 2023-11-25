import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class PopUpItem extends StatelessWidget {
  const PopUpItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colours.primaryColour),
        )
      ],
    );
  }
}
