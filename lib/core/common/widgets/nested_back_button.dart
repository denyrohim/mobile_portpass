import 'package:flutter/material.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: IconButton(
        color: Colours.secondaryColour,
        iconSize: 30,
        icon: Icon(
          Theme.of(context).platform == TargetPlatform.iOS
              ? Icons.arrow_back_ios_new
              : Icons.arrow_back,
        ),
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}