import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/common/app/providers/user_provider.dart';
import '../../../../core/common/widgets/gradient_background.dart';
import '../../../../core/res/media_res.dart';
import '../../../../core/utils/core_utils.dart';
import '../../../dashboard/presentation/views/dashboard.dart';
import '../../data/models/user_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return const GradientBackground(
            image: MediaRes.defaultBackground,
            child: SafeArea(
              child: Center(
                child: Placeholder(
                  fallbackHeight: 100,
                  fallbackWidth: 100,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
