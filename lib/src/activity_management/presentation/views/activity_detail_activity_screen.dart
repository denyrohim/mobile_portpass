import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/qr_code_activity_screen.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/tracking_activity_screen.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/detail_activity.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/list_items_container.dart';

class ActivityDetailActivityScreen extends StatelessWidget {
  const ActivityDetailActivityScreen({
    super.key,
    required this.activity,
  });

  final dynamic activity;

  static const routeName = '/activity-detail-activity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCore(
        isBackButton: true,
        title: 'Detail Aktivitas',
        child:
            (activity.status == "On Progress" || activity.status == "Finished")
                ? GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(context);
                      navigator.pushNamed(
                        TrackingActivityScreen.routeName,
                        arguments: activity,
                      );
                    },
                    child: Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colours.secondaryColour,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              MediaRes.locationIcon,
                              colorFilter: const ColorFilter.mode(
                                Colours.primaryColour,
                                BlendMode.srcATop,
                              ),
                              width: 16,
                            ),
                            const Text(
                              "Lacak",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colours.primaryColour,
                                  fontFamily: Fonts.inter),
                            ),
                          ],
                        )),
                  )
                : null,
      ),
      body: GradientBackground(
          image: MediaRes.colorBackground,
          child: Center(
            child: Stack(
              children: [
                DetailActivity(
                  activity: activity,
                ),
                ContainerCard(
                  mediaHeight: 0.52,
                  header: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        activity.status == "On Progress"
                            ? Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF315784),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colours.primaryColour,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    final navigator = Navigator.of(context);
                                    navigator.pushNamed(
                                        QRCodeActivityScreen.routeName,
                                        arguments: activity);
                                  },
                                  icon: SvgPicture.asset(MediaRes.qrCodeIcon),
                                  label: const Text('Tampilkan QR Code',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Barang",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF315784)),
                            ),
                            Text(
                              "${activity.items.length} Daftar",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF315784)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colours.secondaryColour,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          height: MediaQuery.of(context).size.height * 0.60,
                          child: ListItemsContainer(
                            items: activity.items!,
                            marginTop:
                                activity.status == "On Progress" ? 68 : 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
