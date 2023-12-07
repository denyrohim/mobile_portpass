import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/widgets/pop_up_item.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';

class ActivityManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ActivityManagementAppBar({
    super.key,
    required this.count,
    required this.activityProvider,
  });

  final int count;
  final ActivityProvider activityProvider;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colours.primaryColour,
      foregroundColor: Colours.secondaryColour,
      title: const Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Daftar Aktivitas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Text(
              '$count Daftar',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colours.secondaryColour),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: PopupMenuButton(
                color: Colours.secondaryColourDisabled,
                offset: const Offset(0, 50),
                icon: SvgPicture.asset(MediaRes.moreIcons),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 1,
                    child: const PopUpItem(
                      title: 'Disetujui',
                    ),
                    onTap: () {
                      debugPrint('item pilih di klik');
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const PopUpItem(
                      title: 'Menunggu',
                    ),
                    onTap: () {
                      debugPrint('item pilih semua di klik');
                    },
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: const PopUpItem(
                      title: 'Ditolak',
                    ),
                    onTap: () {
                      debugPrint('item pilih semua di klik');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
