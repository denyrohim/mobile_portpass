import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/report_provider.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/gate_report/presentation/bloc/gate_report_bloc.dart';
import 'package:provider/provider.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({
    super.key,
  });

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Scan GPS",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colours.primaryColour,
                fontFamily: Fonts.inter,
                fontSize: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colours.primaryColour,
              ),
              height: 30,
              width: 30,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(45 / 360),
                child: IconButton(
                  onPressed: () {
                    context.read<GateReportBloc>().add(
                          const GetLocationEvent(),
                        );
                  },
                  icon: SvgPicture.asset(
                    MediaRes.reloadIcon,
                    width: 100,
                    height: 100,
                  ),
                  color: Colours.primaryColour,
                ),
              ),
            ),
          ],
        ),
        Consumer<ReportProvider>(
          builder: (_, reportProvider, __) {
            return Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Latitude",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Text(
                      ": ${reportProvider.location?.latitude ?? "-"}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Longitude",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    ),
                    const SizedBox(
                      width: 45,
                    ),
                    Text(
                      ": ${reportProvider.location?.longitude ?? "-"}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Lokasi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    ),
                    const SizedBox(
                      width: 74,
                    ),
                    Text(
                      ": ${reportProvider.location?.location ?? "-"}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
