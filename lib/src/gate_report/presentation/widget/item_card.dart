import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/item.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.index,
    required this.item,
    this.isEdit = false,
    this.activityType,
  });

  final int index;
  final Item item;
  final bool isEdit;
  final String? activityType;
  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (_, activityProvider, __) {
        return Consumer<FileProvider>(
          builder: (_, fileProvider, __) {
            return Container(
              padding: const EdgeInsets.all(10),
              height: 112,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Colours.itemCardBorderColour,
                      )),
                  color: Colours.secondaryColour,
                  shadows: const [
                    BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0)
                  ]),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: item.image != null
                        ? Image.file(
                            item.image!,
                            width: 88,
                            height: 88,
                            fit: BoxFit.cover,
                          )
                        : item.imagePath != null
                            ? Image.network(
                                item.imagePath!,
                                width: 88,
                                height: 88,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(
                                width: 10,
                                height: 10,
                              ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF315784)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item.amount.toString(),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF315784)),
                        ),
                        Text(
                          item.unit,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF315784)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
