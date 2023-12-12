import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/i_dropdown.dart';
import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:port_pass_app/core/common/widgets/pop_up_item.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';

class ItemForm extends StatefulWidget {
  const ItemForm(
      {required this.nameController,
      required this.weightController,
      required this.photoController,
      required this.unitController,
      required this.fileProvider,
      required this.formKey,
      super.key});

  final TextEditingController nameController;
  final TextEditingController weightController;
  final TextEditingController photoController;
  final TextEditingController unitController;
  final FileProvider fileProvider;
  final GlobalKey<FormState> formKey;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is PhotoAdded) {
          if (state.photo != null) {
            context.read<FileProvider>().initFileEditItem(state.photo);
            context.read<FileProvider>().initFilePathEditItem(state.photo.path);
            widget.photoController.text = state.photo.path;
          } else {
            widget.photoController.text = "";
            context.read<FileProvider>().resetEditItem();
          }
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                          position: PopupMenuPosition.under,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onSelected: (value) {
                            if (value == 1) {
                              context
                                  .read<ActivityManagementBloc>()
                                  .add(const AddPhotoEvent(type: 'camera'));
                            } else if (value == 2) {
                              context
                                  .read<ActivityManagementBloc>()
                                  .add(const AddPhotoEvent(type: 'galery'));
                            }
                          },
                          itemBuilder: (_) => [
                                PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Wrap(
                                          spacing: 2,
                                          children: [
                                            SvgPicture.asset(
                                              MediaRes.itemMenuCameraIcon,
                                              width: 25,
                                            ),
                                            const PopUpItem(
                                              title: 'Kamera',
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: [
                                      Wrap(
                                        spacing: 2,
                                        children: [
                                          SvgPicture.asset(
                                            MediaRes.itemMenuGalleryIcon,
                                            width: 25,
                                          ),
                                          const PopUpItem(
                                            title: 'Galeri',
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  onTap: () async {},
                                )
                              ],
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 15),
                              Text(
                                'Tambah Foto',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.inter,
                                    color: Colours.primaryColour),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colours.primaryColour,
                                size: 50,
                              ),
                            ],
                          )),
                    ],
                  ),
                  widget.fileProvider.fileEditItem != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            widget.fileProvider.fileEditItem!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        )
                      : widget.photoController.text != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.photoController.text,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colours.primaryColour,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Nama Barang',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: Fonts.inter,
                    color: Colours.primaryColour),
              ),
              const SizedBox(
                height: 10,
              ),
              IFields(
                controller: widget.nameController,
                hintText: 'Nama Barang',
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jumlah',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.inter,
                              color: Colours.primaryColour),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IFields(
                          controller: widget.weightController,
                          keyboardType: TextInputType.number,
                          hintText: 'Weight',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Satuan',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.inter,
                              color: Colours.primaryColour),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IDropdown(
                          controller: widget.unitController,
                          hintText: 'Pilih',
                          hintStyle: const TextStyle(
                            color: Colours.primaryColour,
                            fontFamily: Fonts.inter,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: Colours.secondaryColour,
                          items: const [
                            DropdownMenuItem(
                              value: "Satuan",
                              enabled: false,
                              child: Text(
                                'Satuan',
                                style: TextStyle(
                                  color: Colours.primaryColourDisabled,
                                  fontFamily: Fonts.inter,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Ton",
                              child: Text(
                                'Ton',
                                style: TextStyle(
                                  color: Colours.primaryColour,
                                  fontFamily: Fonts.inter,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Kg",
                              child: Text(
                                'Kg',
                                style: TextStyle(
                                  color: Colours.primaryColour,
                                  fontFamily: Fonts.inter,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
