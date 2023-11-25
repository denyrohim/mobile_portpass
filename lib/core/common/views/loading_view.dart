import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Colours.secondaryColour,
          ),
        ),
      ),
    );
  }
}
