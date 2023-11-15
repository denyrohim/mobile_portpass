import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_management_app_bar.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ActivityManagementAppBar(
          title: 'Tambah Aktivitas',
        ),
        backgroundColor: Colors.white,
        body: GradientBackground(
          image: MediaRes.colorBackground,
          child: SafeArea(
            child: Center(
              child: ContainerCard(
                mediaHeight: 0.87,
                children: [
                  Image.asset(
                    MediaRes.logoPortPassColor,
                    height: 172,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
