// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';

class EmployeeForm extends StatelessWidget {
  const EmployeeForm({
    super.key,
    required this.title,
    required this.hintText,
    this.icon,
  });

  final title;
  final hintText;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colours.primaryColour,
            fontFamily: Fonts.inter,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        IFields(
          controller: TextEditingController(),
          hintText: hintText,
          suffixIcon: icon,
        ),
      ],
    );
  }
}
