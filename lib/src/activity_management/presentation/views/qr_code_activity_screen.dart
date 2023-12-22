// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/detail_activity.dart';

class QRCodeActivityScreen extends StatelessWidget {
  const QRCodeActivityScreen({super.key, this.activity});

  final dynamic activity;
  static const routeName = '/qr-code-activity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCore(
        isBackButton: true,
        title: 'Tampilkan QR Code',
      ),
      body: BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.colorBackground,
            child: ContainerCard(
              mediaHeight: 0.86,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: context.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff315784),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailActivity(
                        activity: activity,
                      ),
                      Container(
                        height: context.height * 0.38,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            activity.qrCode == null
                                ? const Text(
                                    'QR Code belum tersedia',
                                    style: TextStyle(
                                      fontFamily: Fonts.inter,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff315784),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          activity.qrCode!,
                                          height: context.width * 0.4,
                                          width: context.width * 0.6,
                                        ),
                                      ),
                                      SizedBox(height: context.height * 0.04),
                                      const Text(
                                        'QR Code',
                                        style: TextStyle(
                                          fontFamily: Fonts.inter,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff315784),
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
