import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_card.dart';

class ListItems extends StatelessWidget {
  const ListItems({
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
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: null,
          icon: SvgPicture.asset("assets/icons/qr_icon.svg"),
          label: const Text('Tampilkan QR Code',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
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
          ItemCard(index: 0, item: items[0]),
          ItemCard(index: 0, item: items[1]),
          ItemCard(index: 0, item: items[2]),
          // Text(items[0].name)
        ],
      )
    ]);
  }
}
