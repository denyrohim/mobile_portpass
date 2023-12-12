import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/widgets/nested_back_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_form.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  const EditItemScreen(
      {super.key,
      required this.item,
      required this.index,
      required this.activityId});

  final Item item;
  final int activityId;
  final int index;

  static const routeName = '/edit-item';

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late Item item;
  late int index, activityId;

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final photoController = TextEditingController();
  final unitController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  bool get nameChanged => item.name.trim() != nameController.text.trim();

  bool get weightChanged =>
      item.amount.toString() != amountController.text.trim();

  bool get photoChanged => item.image != photoController.text.trim();

  bool get unitChanged => item.unit.trim() != unitController.text.trim();

  bool get nothingChanged =>
      !nameChanged && !weightChanged && !photoChanged && !unitChanged;

  void get initController {
    nameController.text = item.name.trim();
    amountController.text = item.amount.toString();
    unitController.text = item.unit.trim();
    photoController.text = item.image ?? "";
    context.read<FileProvider>().initFilePathEditItem(item.image);

    nameController.addListener(() => setState(() {}));
    amountController.addListener(() => setState(() {}));
    unitController.addListener(() => setState(() {}));
    photoController.addListener(() => setState(() {}));
  }

  void get initPage {
    item = widget.item;
    index = widget.index;
    activityId = widget.activityId;
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
  void initState() {
    initPage;
    initController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is ActivityManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataUpdated) {
          item = state.activity.items[index];
          initController;
          CoreUtils.showSnackBar(context, "item berhasil diubah");
        } else if (state is PhotoAdded) {
          CoreUtils.showSnackBar(context, "Foto Berhasil diubah");
        }
      },
      builder: (context, state) {
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
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Consumer<FileProvider>(
                  builder: (_, fileProvider, __) {
                    return ContainerCard(
                      mediaHeight: 0.85,
                      headerHeight: 62,
                      children: [
                        const SizedBox(height: 20),
                        ItemForm(
                            nameController: nameController,
                            weightController: amountController,
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
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<ActivityManagementBloc>()
                                          .add(UpdateItemEvent(
                                              activityId: activityId,
                                              item: Item(
                                                  name: nameController.text
                                                      .trim(),
                                                  amount: int.parse(
                                                      amountController.text),
                                                  unit: unitController.text
                                                      .trim(),
                                                  image: fileProvider
                                                      .uriEditItem)));
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
                            })
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
