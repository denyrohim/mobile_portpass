// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/detail_activity.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeActivityScreen extends StatelessWidget {
  const QRCodeActivityScreen({super.key});

  static const routeName = '/qr-code-activity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCore(
        title: 'Tampilkan QR Code',
      ),
      body: GradientBackground(
        image: MediaRes.colorBackground,
        child: ContainerCard(
          mediaHeight: 0.86,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 540,
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
                  const DetailActivity(),
                  Container(
                    height: 336,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QrImageView(
                          data: 'marko kontol',
                          size: 222,
                          version: QrVersions.auto,
                          foregroundColor: const Color(0xff315784),
                        ),
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
