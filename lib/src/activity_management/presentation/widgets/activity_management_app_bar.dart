import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/res/colours.dart';

class ActivityManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ActivityManagementAppBar(
      {super.key, required this.title, this.image, this.pressAction});

  final String title;
  final String? image;
  final VoidCallback? pressAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        image != null
            ? Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                    onTap: pressAction,
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colours.secondaryColour,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            image!,
                            height: 30,
                            width: 30,
                          ),
                          const Text(
                            'Lacak',
                            style: TextStyle(
                              color: Colours.primaryColour,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    )),
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
