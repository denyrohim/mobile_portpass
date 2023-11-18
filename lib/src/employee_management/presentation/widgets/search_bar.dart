import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  const CustomSearchBar({super.key, required this.onSearch});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: 42,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(10)
          )
      ),
      child: TextField(
          controller: controller,
          onChanged: (query){
            widget.onSearch(query);
          },
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.021),
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
                      fontWeight: FontWeight.w500
                  ),
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
          )
      ),
    );
  }
}
