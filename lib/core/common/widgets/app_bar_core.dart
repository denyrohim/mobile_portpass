import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';

class AppBarCore extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCore({
    super.key,
    required this.title,
    this.icon,
    this.child,
    this.size = 20,
    this.isBackButton = false,
  });

  final Icon? icon;
  final String title;
  final Widget? child;
  final double? size;
  final bool? isBackButton;

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
            isBackButton == true
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colours.secondaryColour,
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.red,
                  )
                : const SizedBox.shrink(),
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
