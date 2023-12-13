import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
  });

  final Item item;
  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              item.image != null
                  ? Image.asset(item.image.toString())
                  : const SizedBox(
                      width: 10,
                    ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF315784)),
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
          )
        ],
      ),
    );
  }
}
