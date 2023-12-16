import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_card.dart';

class ListItemsContainer extends StatelessWidget {
  const ListItemsContainer({
    super.key,
    required this.items,
    required this.marginTop,
  });

  final dynamic items;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
      margin: EdgeInsets.only(top: marginTop),
      decoration: const BoxDecoration(
        color: Colours.secondaryColour,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          items.isEmpty
              ? const Center(
                  child: Text(
                    '0 Daftar',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ItemCard(
                        item: items[index],
                        index: index,
                      ),
                    );
                  }),
        ],
      ),
    );
  }
}
