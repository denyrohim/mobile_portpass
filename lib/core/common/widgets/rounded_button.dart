import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      this.backgroundColor,
      this.foregroundColor,
      required this.onPressed,
      required this.text,
      this.fontFamily,
      this.fontWeight,
      this.horizontalPadding,
      this.verticalPadding,
      this.radius});

  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final String text;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 50,
          vertical: verticalPadding ?? 17,
        ),
        backgroundColor: backgroundColor ?? Colours.primaryColour,
        foregroundColor: foregroundColor ?? Colors.white,
      ),
      onPressed: () async {
        onPressed();
      },
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily ?? Fonts.inter,
          fontWeight: fontWeight ?? FontWeight.bold,
        ),
      ),
    );
  }
}
