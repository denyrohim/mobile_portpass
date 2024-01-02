import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';
import 'package:provider/provider.dart';

class AddEmployeePhotoScreen extends StatefulWidget {
  const AddEmployeePhotoScreen({
    super.key,
    required this.photoController,
  });

  final TextEditingController photoController;

  static const routeName = '/add-employee-photo';

  @override
  State<AddEmployeePhotoScreen> createState() => _AddEmployeePhotoScreenState();
}

class _AddEmployeePhotoScreenState extends State<AddEmployeePhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
      listener: (context, state) {
        // debugPrint("state: $state");
        if (state is PhotoAdded) {
          if (state.photo != null) {
            context.read<FileProvider>().initFileAddEmployee(state.photo);
            context
                .read<FileProvider>()
                .initFilePathAddEmployee(state.photo.path);
            widget.photoController.text = state.photo.path;
          } else {
            widget.photoController.text = "";
            context.read<FileProvider>().resetAddEmployee();
          }
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colours.primaryColour,
            leading: IconButton(
              color: Colours.secondaryColour,
              iconSize: 30,
              icon: Icon(
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Icons.arrow_back_ios_new
                    : Icons.arrow_back,
              ),
              onPressed: () {
                final navigator = Navigator.of(context);
                if (navigator.canPop()) {
                  navigator.pop();
                }
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: GradientBackground(
            image: MediaRes.colorBackground,
            child: ContainerCard(
              mediaHeight: 0.8,
              headerHeight: 52,
              header: Consumer<FileProvider>(
                builder: (_, fileProvider, __) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: fileProvider.fileAddEmployee != null
                            ? Image.file(
                                fileProvider.fileAddEmployee!,
                                width: 104,
                                height: 104,
                                fit: BoxFit.cover,
                              )
                            : widget.photoController.text != ""
                                ? Image.network(
                                    widget.photoController.text,
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
                    ],
                  );
                },
              ),
              padding: 80,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tambah Foto Profil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colours.primaryColour,
                      fontFamily: Fonts.inter,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    context.read<EmployeeManagementBloc>().add(
                          const AddPhotoEvent(type: 'camera'),
                        );
                  },
                  child: Container(
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colours.primaryColour,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colours.secondaryColour,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colours.primaryColour,
                            size: 40,
                          ),
                        ),
                        const Text(
                          'Kamera',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colours.secondaryColour,
                            fontFamily: Fonts.inter,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.read<EmployeeManagementBloc>().add(
                          const AddPhotoEvent(type: 'galery'),
                        );
                  },
                  child: Container(
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colours.primaryColour,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colours.secondaryColour,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Colours.primaryColour,
                            size: 40,
                          ),
                        ),
                        const Text(
                          'Galeri',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colours.secondaryColour,
                            fontFamily: Fonts.inter,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.read<EmployeeManagementBloc>().add(
                          const AddPhotoEvent(type: 'remove'),
                        );
                  },
                  child: Container(
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colours.primaryColour,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colours.secondaryColour,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colours.primaryColour,
                            size: 40,
                          ),
                        ),
                        const Text(
                          'Tanpa Foto',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colours.secondaryColour,
                            fontFamily: Fonts.inter,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
