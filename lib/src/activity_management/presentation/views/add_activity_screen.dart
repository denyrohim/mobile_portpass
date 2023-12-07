import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/media_res.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCore(
          title: 'Tambah Aktivitas',
        ),
        backgroundColor: Colors.white,
        body: GradientBackground(
          image: MediaRes.colorBackground,
          child: Center(
            child: ContainerCard(
              mediaHeight: 0.75,
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
        ));
  }
}
