import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

PopupMenuItem buildPopMenuItem(String title, int position){
  return PopupMenuItem(
      value: position,
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colours.primaryColour
        ),
      )
  );
}
