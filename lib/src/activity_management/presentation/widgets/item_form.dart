import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/i_dropdown.dart';
import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:port_pass_app/core/common/widgets/pop_up_item.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({required this.nameController,
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
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Tambah Foto',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: Fonts.inter,
                    color: Colours.primaryColour),
              ),
              PopupMenuButton(
                offset: const Offset(0, 50),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colours.primaryColour,
                  size: 50,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                itemBuilder: (_) =>
                [
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
                      )
                  ),
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
                    onTap: () async {
                      
                    },
                  )
                ],
              )
            ],
          ),
          widget.fileProvider.fileEditItem != null
            ? Image.file(
                widget.fileProvider.fileEditItem!,
                width: 100,
                height: 100,
              )
            : widget.photoController.text != ""
              ? Image.network(
                  widget.photoController.text,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colours.primaryColour,
                    borderRadius: BorderRadius.circular(5)
                  ),
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
                      hintText: 'Weight',
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
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
                              color: Colours.primaryColour,
                              fontFamily: Fonts.inter,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "----",
                          enabled: false,
                          child: Divider(
                            color: Colours.primaryColour,
                            height: 2,
                            thickness: 1,
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
  }
}
