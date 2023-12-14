import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 80),
            Container(
              padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
              decoration: const BoxDecoration(
                color: Colours.secondaryColour,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.45,
              child: Stack(
                children: [
                  ListView.builder(
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
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ],
    );
  }
}
