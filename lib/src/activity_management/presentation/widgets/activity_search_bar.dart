import 'package:flutter/material.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';

class ActivitySearchBar extends StatefulWidget {
  const ActivitySearchBar({super.key});

  @override
  State<ActivitySearchBar> createState() => _ActivitySearchBarState();
}

class _ActivitySearchBarState extends State<ActivitySearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: 42,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
          controller: controller,
          onChanged: (query) {
            // context.activityProvider.setSearchText(query);
            context.activityProvider.setSearchText(query);
          },
          style: const TextStyle(
            fontSize: 16,
            color: Colours.primaryColour,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: const TextStyle(fontSize: 12),
            label: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cari ...',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colours.primaryColour,
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.search,
                  color: Colours.primaryColour,
                  weight: 500,
                  size: 21,
                ),
              ],
            ),
            focusColor: Colours.primaryColour,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colours.primaryColour, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          )),
    );
  }
}
