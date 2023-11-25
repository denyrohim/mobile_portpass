import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class AppBarCore extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCore({
    super.key,
    required this.title,
    this.icon,
    this.child,
    this.size = 20,
  });

  final Icon? icon;
  final String title;
  final Widget? child;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        child != null
            ? Padding(
                padding: const EdgeInsets.only(right: 20),
                child: child,
              )
            : const SizedBox.shrink(),
      ],
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
            icon ??
                IconButton(
                  icon: icon!,
                  onPressed: () => Navigator.pop(context),
                  color: Colors.red,
                ),
            Text(
              title,
              style: TextStyle(
                color: Colours.secondaryColour,
                fontSize: size,
                fontWeight: FontWeight.w700,
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
