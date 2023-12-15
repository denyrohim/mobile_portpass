import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_card.dart';

class ListItemsContainer extends StatelessWidget {
  const ListItemsContainer({
    super.key,
    required this.items,
  });

  final dynamic items;

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
              child: items.isEmpty
                  ? SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          '0 Daftar',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: Fonts.inter,
                            color: Colours.primaryColour.withOpacity(0.5),
                          ),
                        ),
                      ),
                    )
                  : Stack(
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
