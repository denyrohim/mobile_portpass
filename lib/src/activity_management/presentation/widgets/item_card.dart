import 'package:flutter/material.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
  });

  final Item item;
  @override
  Widget build(BuildContext context) {
    final split = item.weight.split(' ');
    return Container(
      padding: const EdgeInsets.all(10),
      height: 112,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 10,
              blurStyle: BlurStyle.outer)
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset(item.image),
              const SizedBox(
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
                split[0],
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF315784)),
              ),
              Text(
                split[1],
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