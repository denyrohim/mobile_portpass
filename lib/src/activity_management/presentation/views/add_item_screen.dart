import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_form.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});
  static const routeName = '/add-item';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final photoController = TextEditingController();
  final unitController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  void get initController {
    nameController.text = "";
    amountController.text = "";
    unitController.text = "";
    photoController.text = "";
    context.read<FileProvider>().initFilePathEditItem("");

    nameController.addListener(() => setState(() {}));
    amountController.addListener(() => setState(() {}));
    unitController.addListener(() => setState(() {}));
    photoController.addListener(() => setState(() {}));
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
    initController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is ActivityManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is PhotoAdded) {
          CoreUtils.showSnackBar(context, "Foto Berhasil diubah");
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: const AppBarCore(
              title: 'Tambahan Barang',
              isBackButton: true,
            ),
            body: GradientBackground(
              image: MediaRes.colorBackground,
              child: SingleChildScrollView(
                reverse: true,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child:
                        Consumer<FileProvider>(builder: (_, fileProvider, __) {
                      return ContainerCard(
                        mediaHeight: 0.85,
                        children: [
                          ItemForm(
                              nameController: nameController,
                              weightController: amountController,
                              photoController: photoController,
                              unitController: unitController,
                              fileProvider: fileProvider,
                              formKey: formKey),
                          StatefulBuilder(
                              key: key,
                              builder: (_, refresh) {
                                return IgnorePointer(
                                  ignoring: true,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (formKey.currentState!.validate()) {
                                        context
                                            .read<ActivityManagementBloc>()
                                            .add(AddItemEvent(
                                                items: List.empty(),
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
                                        backgroundColor: true
                                            ? Colours.primaryColourDisabled
                                            : Colours.primaryColour,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: "sa" is ActivityManagementLoading
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
                    })),
              ),
            ));
      },
    );
  }
}
