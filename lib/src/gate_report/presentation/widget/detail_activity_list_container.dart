import 'package:flutter/material.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_card.dart';

class GateListItems extends StatelessWidget {
  const GateListItems({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF315784),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: null,
            label: const Text('Lanjutkan',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Daftar Barang",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF315784)),
          ),
          Text(
            "5 Daftar",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF315784)),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Wrap(
        runSpacing: 15,
        children: [
          // ListView.builder(itemCount: items.length,itemBuilder: (BuildContext context, int index) {
          //   return _Item(item: items[index]);
          // }),
          ItemCard(item: items[0]),
          ItemCard(item: items[1]),
          ItemCard(item: items[2]),
          // Text(items[0].name)
        ],
      )
    ]);
  }
}
