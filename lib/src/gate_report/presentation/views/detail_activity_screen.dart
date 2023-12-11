import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

import 'package:port_pass_app/src/activity_management/presentation/widgets/detail_activity.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/detail_activity_list_container.dart';

class GateDetailActivityScreen extends StatefulWidget {
  const GateDetailActivityScreen({super.key});

  static const routeName = '/gate-detail-activity';

  @override
  State<GateDetailActivityScreen> createState() =>
      _GateDetailActivityScreenState();
}

class _GateDetailActivityScreenState extends State<GateDetailActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colours.primaryColour,
        leading: IconButton(
          color: Colours.secondaryColour,
          iconSize: 30,
          icon: Icon(
            Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.arrow_back_ios_new
                : Icons.arrow_back,
          ),
          onPressed: () {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            }
          },
        ),
        title: const Text(
          "Detail Aktivitas",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colours.secondaryColour,
          ),
        ),
      ),
      body: const GradientBackground(
        image: MediaRes.colorBackground,
        child: SafeArea(
          child: Center(
            child: Stack(
              children: [
                DetailActivity(),
                ContainerCard(mediaHeight: 0.6, children: [
                  Column(
                    children: [
                      GateListItems(
                        items: [
                          Item(
                            image: 'assets/icons/flutter.png',
                            name: "sasa",
                            amount: 10,
                            unit: 'ton'
                          ),
                          Item(
                            image: 'assets/icons/flutter.png',
                            name: "ssadasa",
                            amount: 10,
                            unit: 'ton'
                          ),
                          Item(
                            image: 'assets/icons/flutter.png',
                            name: "safdsfsa",
                            amount: 10,
                            unit: 'ton'
                          )
                        ],
                      ),
                    ],
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
