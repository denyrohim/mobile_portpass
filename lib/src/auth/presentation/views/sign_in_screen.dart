import 'package:port_pass_app/core/common/app/providers/user_provider.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:port_pass_app/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:port_pass_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/container_card.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.defaultBackground,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ContainerCard(
                  backgroundColor: Colours.secondaryColour,
                  header: Stack(
                    children: [
                      Container(
                        width: 72,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colours.primaryColour,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ],
                  ),
                  mediaHeight: 0.86,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      MediaRes.logoPortPassColor,
                      height: 172,
                    ),
                    const SizedBox(height: 20),
                    SignInForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey,
                    ),
                    const SizedBox(height: 30),
                    if (state is AuthLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      RoundedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  SignInEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                        text: 'Masuk',
                      ),
                    const SizedBox(height: 500),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
