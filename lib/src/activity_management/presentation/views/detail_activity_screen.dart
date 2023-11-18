import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_management_app_bar.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/detail_activity.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/detail_activity_list_container.dart';

class DetailActivityScreen extends StatelessWidget {
  const DetailActivityScreen({super.key});

  static const routeName = '/detail-activity';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ActivityManagementAppBar(
        title: 'Tambah Aktivitas',
        image: "assets/icons/track_icon.svg",
      ),
      body: GradientBackground(
          image: MediaRes.colorBackground,
          child: SafeArea(
              child: Center(
            child: Stack(
              children: [
                DetailActivity(),
                ContainerCard(mediaHeight: 0.6, children: [
                  Column(
                    children: [
                      ListItems(
                        items: [
                          Item(
                              image: 'assets/icons/flutter.png',
                              name: "sasa",
                              weight: '10 ton'),
                          Item(
                              image: 'assets/icons/flutter.png',
                              name: "ssadasa",
                              weight: '10 ton'),
                          Item(
                              image: 'assets/icons/flutter.png',
                              name: "safdsfsa",
                              weight: '10 ton')
                        ],
                      ),
                    ],
                  )
                ]),
              ],
            ),
          ))),
    );
  }
}



