import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/widgets/nested_back_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_form.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  const EditItemScreen({super.key, required this.item});

  final Item item;

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late Item item;

  final nameController = TextEditingController();
  final weightController = TextEditingController();
  final photoController = TextEditingController();
  final unitController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  bool get nameChanged => item.name.trim() != nameController.text.trim();

  bool get weightChanged =>
      item.amount.toString() != weightController.text.trim();

  bool get photoChanged => item.image != photoController.text.trim();

  bool get unitChanged => item.unit.trim() != unitController.text.trim();

  bool get nothingChanged =>
      !nameChanged &&
      !weightChanged &&
      !photoChanged &&
      !unitChanged;

  void get initController {
    nameController.text = item.name.trim();
    weightController.text = item.amount.toString();
    unitController.text = item.unit.trim();
    photoController.text = item.image ?? "";
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    unitController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colours.primaryColour,
        leading: NestedBackButton(
          onPressed: context.read<FileProvider>().resetEditItem,
        ),
        title: const Text(
          "Edit Tambahan Barang",
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<FileProvider>(
            builder: (_, fileProvider, __) {
              return ContainerCard(
                mediaHeight: 0.75,
                headerHeight: 62,
                header: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: fileProvider.fileEditItem != null
                          ? Image.file(
                              fileProvider.fileEditItem!,
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
                                  padding: const EdgeInsets.all(24),
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
                          // Navigator.pushNamed(context, routeName)
                        },
                        child: Container(
                          width: 30.15,
                          height: 30.15,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: Colours.primaryColour),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 5))
                              ]),
                          child: Transform.scale(
                            scale: 0.5,
                            child: SvgPicture.asset(
                                MediaRes.changePhotoProfileIcon),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                children: [
                  const SizedBox(height: 40),
                  ItemForm(
                      nameController: nameController,
                      weightController: weightController,
                      photoController: photoController,
                      unitController: unitController,
                      fileProvider: fileProvider,
                      formKey: formKey),
                  const SizedBox(height: 30),
                  StatefulBuilder(
                      key: key,
                      builder: (_, refresh) {
                        return IgnorePointer(
                          ignoring: nothingChanged,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: nothingChanged
                                  ? Colours.primaryColourDisabled
                                  : Colours.primaryColour,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            child: const Text(
                              "Simpan",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Fonts.inter,
                                  color: Colours
                                      .secondaryColour),
                            ),
                          ),
                        );
                      })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
