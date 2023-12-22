import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/widgets/pop_up_item.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_form.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  const EditItemScreen({super.key, required this.activityType});
  static const routeName = '/edit-item';

  final dynamic activityType;

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late int index;
  late Item item;

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final photoController = TextEditingController();
  final unitController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool get nameChanged => item.name != nameController.text.trim();
  bool get amountChanged => "${item.amount}" != amountController.text.trim();
  bool get photoChanged => item.imagePath != photoController.text.trim();
  bool get unitChanged => item.unit != unitController.text.trim();

  bool get nothingChanged =>
      !nameChanged && !amountChanged && !photoChanged && !unitChanged;

  bool get allChanged =>
      nameChanged && amountChanged && photoChanged && unitChanged;

  final key = GlobalKey();

  void get initController {
    nameController.text = item.name;
    amountController.text = "${item.amount}";
    unitController.text = item.unit;
    photoController.text = item.imagePath ?? "";

    nameController.addListener(() => setState(() {}));
    amountController.addListener(() => setState(() {}));
    unitController.addListener(() => setState(() {}));
    photoController.addListener(() => setState(() {}));
  }

  void get initItem {
    index = context.read<ActivityProvider>().itemIndex!;
    if (widget.activityType == 'Add') {
      item = context.read<ActivityProvider>().itemsAddActivity[index];
    } else {
      item = context.read<ActivityProvider>().itemsEditActivity[index];
    }
  }

  @override
  void initState() {
    initItem;
    initController;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    unitController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is ActivityManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is PhotoAdded) {
          if (state.photo != null) {
            if (widget.activityType == 'Add') {
              context
                  .read<ActivityProvider>()
                  .updateImageItemAddActivity(state.photo, index);
            } else {
              context
                  .read<ActivityProvider>()
                  .updateImageItemEditActivity(state.photo, index);
            }
            initItem;
          }
        } else if (state is ItemAdded) {
          if (widget.activityType == 'Add') {
            context.read<ActivityProvider>().initItemsAddActivity(state.items);
          } else {
            context.read<ActivityProvider>().initItemsEditActivity(state.items);
          }
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: const AppBarCore(
              title: 'Edit Barang',
              isBackButton: true,
            ),
            body: GradientBackground(
              image: MediaRes.colorBackground,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Consumer<FileProvider>(builder: (_, fileProvider, __) {
                    return ContainerCard(
                      mediaHeight: 0.85,
                      children: [
                        Consumer<FileProvider>(
                          builder: (_, fileProvider, __) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PopupMenuButton(
                                        position: PopupMenuPosition.under,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        onSelected: (value) {
                                          if (value == 1) {
                                            context
                                                .read<ActivityManagementBloc>()
                                                .add(const AddPhotoEvent(
                                                    type: 'camera'));
                                          } else if (value == 2) {
                                            context
                                                .read<ActivityManagementBloc>()
                                                .add(const AddPhotoEvent(
                                                    type: 'galery'));
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
                                                            MediaRes
                                                                .itemMenuCameraIcon,
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
                                                          MediaRes
                                                              .itemMenuGalleryIcon,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                item.image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          item.image!,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : photoController.text != ""
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              photoController.text,
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ))
                                        : Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color: Colours.neutralTextColour,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Transform.scale(
                                              scale: 0.5,
                                              child: SvgPicture.asset(
                                                MediaRes.noImage,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Colours.primaryColour,
                                                  BlendMode.srcATop,
                                                ),
                                              ),
                                            ),
                                          ),
                              ],
                            );
                          },
                        ),
                        ItemForm(
                            nameController: nameController,
                            weightController: amountController,
                            unitController: unitController,
                            formKey: formKey),
                        const SizedBox(height: 20),
                        StatefulBuilder(
                            key: key,
                            builder: (_, refresh) {
                              return IgnorePointer(
                                ignoring: nothingChanged,
                                child: Consumer<ActivityProvider>(
                                  builder: (_, activityProvider, __) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        if (formKey.currentState!.validate()) {
                                          context
                                              .read<ActivityManagementBloc>()
                                              .add(
                                                AddItemEvent(
                                                  items: widget.activityType ==
                                                          "Add"
                                                      ? activityProvider
                                                          .itemsAddActivity
                                                      : activityProvider
                                                          .itemsEditActivity,
                                                  item: Item(
                                                    id: item.id,
                                                    name: nameController.text
                                                        .trim(),
                                                    amount: int.parse(
                                                        amountController.text
                                                            .trim()),
                                                    unit: unitController.text
                                                        .trim(),
                                                    imagePath: photoController
                                                        .text
                                                        .trim(),
                                                    image: item.image,
                                                  ),
                                                  index: index,
                                                ),
                                              );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: nothingChanged
                                              ? Colours.primaryColourDisabled
                                              : Colours.primaryColour,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: state is ActivityManagementLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                              color: Colours.secondaryColour,
                                            ))
                                          : const Text(
                                              "Simpan",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: Fonts.inter,
                                                  color:
                                                      Colours.secondaryColour),
                                            ),
                                    );
                                  },
                                ),
                              );
                            })
                      ],
                    );
                  })),
            ));
      },
    );
  }
}
