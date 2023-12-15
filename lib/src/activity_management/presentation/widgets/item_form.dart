import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/widgets/i_dropdown.dart';
import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';

class ItemForm extends StatefulWidget {
  const ItemForm(
      {required this.nameController,
      required this.weightController,
      required this.unitController,
      required this.formKey,
      super.key});

  final TextEditingController nameController;
  final TextEditingController weightController;
  final TextEditingController unitController;
  final GlobalKey<FormState> formKey;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                  color: Colours.primaryColour,
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
