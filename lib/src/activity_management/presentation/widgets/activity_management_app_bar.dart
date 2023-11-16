import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class ActivityManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ActivityManagementAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colours.primaryColour,
      foregroundColor: Colours.secondaryColour,
      elevation: 0,
      leadingWidth: double.infinity,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colours.secondaryColour,
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.red,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colours.secondaryColour,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
