import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/services/injection_container.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:port_pass_app/src/profile/presentation/views/edit_profile_screen.dart';

class BodyButtonProfile extends StatelessWidget {
  const BodyButtonProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text(
          "Abdul",
          style: TextStyle(
            color: Colours.primaryColour,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.none,
            fontFamily: Fonts.inter,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Laborumi",
          style: TextStyle(
            color: Colours.primaryColour,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
            fontFamily: Fonts.inter,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            context.push(BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const EditProfileScreen(),
            ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colours.primaryColour,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            width: 200,
            height: 96,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 64,
                      height: 64,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Transform.scale(
                        scale: 0.5,
                        child: SvgPicture.asset(
                          MediaRes.editIcon,
                        ),
                      )),
                  const SizedBox(width: 20),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: Fonts.inter),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            context.read<AuthBloc>().add(const SignOutEvent());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colours.primaryColour,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            width: 200,
            height: 96,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 64,
                      height: 64,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Transform.scale(
                        scale: 0.5,
                        child: SvgPicture.asset(
                          MediaRes.exitIcon,
                        ),
                      )),
                  const SizedBox(width: 20),
                  const Text(
                    'Keluar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
