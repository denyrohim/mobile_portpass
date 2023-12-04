import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/nested_back_button.dart';
import 'package:port_pass_app/core/enums/update_user_action.dart';
import 'package:port_pass_app/core/extensions/context_extensions.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:port_pass_app/src/profile/presentation/views/edit_photo_profile_screen.dart';
import 'package:port_pass_app/src/profile/presentation/widgets/edit_profile_form.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const routeName = '/editprofile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late LocalUser user;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final photoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  XFile? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = XFile(image.path);
      });
    }
  }

  bool get nameChanged =>
      context.currentUser?.name.trim() != nameController.text.trim();

  bool get emailChanged =>
      context.currentUser?.email.trim() != emailController.text.trim();

  bool get photoChanged =>
      context.currentUser?.profileImg != photoController.text.trim();

  bool get nothingChanged => !nameChanged && !emailChanged && !photoChanged;

  void get initController {
    nameController.text = context.currentUser!.name.trim();
    emailController.text = context.currentUser!.email.trim();
    photoController.text = context.currentUser!.profileImg ?? "";

    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    photoController.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    initController;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is PhotoProfileAdded) {
          CoreUtils.showSnackBar(context, "Foto berhasil diubah");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colours.primaryColour,
            leading: NestedBackButton(
              onPressed: context.fileProvider.resetEditUser,
            ),
            title: const Text(
              "Edit Profile",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colours.secondaryColour,
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: GradientBackground(
            image: MediaRes.colorBackground,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ContainerCard(
                  mediaHeight: 0.8,
                  headerHeight: 52,
                  header:
                      Consumer<FileProvider>(builder: (_, fileProvider, __) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: fileProvider.fileEditUser != null
                              ? Image.file(
                                  fileProvider.fileEditUser!,
                                  width: 104,
                                  height: 104,
                                  fit: BoxFit.cover,
                                )
                              : photoController.text != ""
                                  ? Image.network(
                                      photoController.text,
                                      width: 104,
                                      height: 104,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 104,
                                      height: 104,
                                      padding: const EdgeInsets.only(
                                        left: 24,
                                        top: 24,
                                        right: 24,
                                        bottom: 24,
                                      ),
                                      color: Colours.profileBackgroundColour,
                                      child: SvgPicture.asset(
                                        MediaRes.profileIcon,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, EditPhotoProfileScreen.routeName,
                                  arguments: photoController);
                            },
                            child: Container(
                              width: 30.15,
                              height: 30.15,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colours.primaryColour,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset(
                                  MediaRes.changePhotoProfileIcon,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  children: [
                    const SizedBox(height: 40),
                    EditProfileForm(
                      nameController: nameController,
                      emailController: emailController,
                      formKey: formKey,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 40,
                          child: IgnorePointer(
                            ignoring: nothingChanged || state is AuthLoading,
                            child: ElevatedButton(
                              onPressed: () {
                                initController;
                                context.read<FileProvider>().resetEditUser();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: nothingChanged
                                    ? Colours.primaryColourDisabled
                                    : Colours.primaryColour,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: state is AuthLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : const Text(
                                      "Batal",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: Fonts.inter,
                                          color: Colours.secondaryColour),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          height: 40,
                          child: StatefulBuilder(
                            key: key,
                            builder: (_, refresh) {
                              return IgnorePointer(
                                ignoring:
                                    nothingChanged || state is AuthLoading,
                                child: ElevatedButton(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                            UpdateUserEvent(
                                              actions: [
                                                if (nameChanged)
                                                  UpdateUserAction.name,
                                                if (emailChanged)
                                                  UpdateUserAction.email,
                                              ],
                                              userData: LocalUser(
                                                id: user.id,
                                                name:
                                                    nameController.text.trim(),
                                                role: user.role,
                                                email:
                                                    emailController.text.trim(),
                                              ),
                                            ),
                                          );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: nothingChanged
                                        ? Colours.primaryColourDisabled
                                        : Colours.primaryColour,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: state is AuthLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : const Text(
                                          "Simpan",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: Fonts.inter,
                                              color: Colours.secondaryColour),
                                        ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
