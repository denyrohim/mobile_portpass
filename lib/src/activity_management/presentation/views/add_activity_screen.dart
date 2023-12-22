import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_approval_card.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/add_item_screen.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_form.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_card.dart';
import 'package:provider/provider.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  static const routeName = '/add-activity';

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final nameController = TextEditingController();
  final shipNameController = TextEditingController();
  final activityTypeController = TextEditingController();
  final activityDateController = TextEditingController();
  final activityHourController = TextEditingController();
  final activityRouteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  bool get nameChanged => nameController.text.trim() != "";

  bool get shipNameChanged => shipNameController.text.trim() != "";

  bool get activityTypeChanged => activityTypeController.text.trim() != "";

  bool get activityDateChanged => activityDateController.text.trim() != "";

  bool get activityHourChanged => activityHourController.text.trim() != "";

  bool get activityRouteChanged => activityRouteController.text.trim() != "";

  bool get itemsChanged =>
      context.read<ActivityProvider>().itemsAddActivity.toString() != "[]";

  bool get nothingChanged =>
      !nameChanged &&
      !shipNameChanged &&
      !activityTypeChanged &&
      !activityDateChanged &&
      !activityHourChanged &&
      !activityRouteChanged &&
      !itemsChanged;

  bool get allChanged =>
      nameChanged &&
      shipNameChanged &&
      activityTypeChanged &&
      activityDateChanged &&
      activityHourChanged &&
      activityRouteChanged &&
      itemsChanged;

  void get initController {
    nameController.text = "";
    shipNameController.text = "";
    activityTypeController.text = "";
    activityDateController.text = "";
    activityHourController.text = "";
    activityRouteController.text = "";
    context.read<ActivityProvider>().resetItemsAddActivity();

    nameController.addListener(() => setState(() {}));
    shipNameController.addListener(() => setState(() {}));
    activityTypeController.addListener(() => setState(() {}));
    activityDateController.addListener(() => setState(() {}));
    activityHourController.addListener(() => setState(() {}));
    activityRouteController.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    context.read<ActivityManagementBloc>().add(const GetShipsEvent());
    context.read<ActivityManagementBloc>().add(const GetActivityRoutesEvent());
    initController;
  }

  @override
  void dispose() {
    nameController.dispose();
    shipNameController.dispose();
    activityTypeController.dispose();
    activityDateController.dispose();
    activityHourController.dispose();
    activityRouteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is ActivityManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataAdded) {
          context.read<ActivityProvider>().addActivities(state.activity);
          context.read<ActivityProvider>().initDefaultActivities(
              context.read<ActivityProvider>().activities!);
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return BottomSheetApprovalCard(
                name: state.activity.name,
                shipName: state.activity.shipName,
                type: state.activity.type,
                date: state.activity.date,
                status: state.activity.status,
                route: state.activity.route ?? '-',
              );
            },
          );
          // initController;
        } else if (state is ShipsLoaded) {
          context.read<ActivityProvider>().initShips(state.ships);
        } else if (state is ActivityRoutesLoaded) {
          context
              .read<ActivityProvider>()
              .initActivityRoutes(state.activityRoutes);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colours.primaryColour,
            foregroundColor: Colours.secondaryColour,
            scrolledUnderElevation: 0,
            elevation: 0,
            leadingWidth: double.infinity,
            leading: Container(
              margin: const EdgeInsets.only(left: 28),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tambah Aktivitas',
                    style: TextStyle(
                      color: Colours.secondaryColour,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: GradientBackground(
            image: MediaRes.colorBackground,
            child: Consumer<ActivityProvider>(
              builder: (_, activityProvider, __) {
                return ContainerCard(
                  mediaHeight: 0.76,
                  padding: 10,
                  children: [
                    const SizedBox(height: 10),
                    ActivityForm(
                      nameController: nameController,
                      shipNameController: shipNameController,
                      activityTypeController: activityTypeController,
                      activityDateController: activityDateController,
                      activityHourController: activityHourController,
                      activityRouteController: activityRouteController,
                      formKey: formKey,
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 200,
                        height: 28,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.primaryColour,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            final navigator = Navigator.of(context);
                            navigator.pushNamed(AddItemScreen.routeName,
                                arguments: "Add");
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                MediaRes.addWhiteIcon,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Tambah Barang",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: Fonts.inter,
                                    color: Colours.secondaryColour),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daftar Barang',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.inter,
                              color: Colours.primaryColour),
                        ),
                        Text(
                          '${activityProvider.itemsAddActivity.length} Daftar',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.inter,
                              color: Colours.primaryColour),
                        ),
                      ],
                    ),
                    activityProvider.itemsAddActivity.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Wrap(
                              runSpacing: 15,
                              children: [
                                for (var item
                                    in activityProvider.itemsAddActivity)
                                  ItemCard(
                                    index: activityProvider.itemsAddActivity
                                        .indexOf(item),
                                    item: activityProvider.itemsAddActivity[
                                        activityProvider.itemsAddActivity
                                            .indexOf(item)],
                                    isEdit: true,
                                    activityType: "Add",
                                  ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 150,
                            child: Center(
                              child: Text(
                                '0 Daftar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: Fonts.inter,
                                  color: Colours.primaryColour.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 40,
                          child: IgnorePointer(
                            ignoring: nothingChanged ||
                                state is ActivityManagementLoading,
                            child: ElevatedButton(
                              onPressed: () {
                                initController;
                                context.read<FileProvider>().resetFileAddItem();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: nothingChanged
                                    ? Colours.primaryColourDisabled
                                    : Colours.primaryColour,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: state is ActivityManagementLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colours.secondaryColour,
                                    ))
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
                                  ignoring: !allChanged ||
                                      state is ActivityManagementLoading,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (formKey.currentState!.validate()) {
                                        context
                                            .read<ActivityManagementBloc>()
                                            .add(
                                              AddActivityEvent(
                                                activityData: Activity(
                                                  id: 0,
                                                  name: nameController.text
                                                      .trim(),
                                                  shipName: shipNameController
                                                      .text
                                                      .trim(),
                                                  type: activityTypeController
                                                      .text
                                                      .trim(),
                                                  date: activityDateController
                                                      .text
                                                      .trim(),
                                                  time: activityHourController
                                                      .text
                                                      .trim(),
                                                  route: activityRouteController
                                                      .text
                                                      .trim(),
                                                  items: activityProvider
                                                      .itemsAddActivity,
                                                  status: "Pending",
                                                  activityProgress: const [],
                                                  qrCode: null,
                                                  isChecked: false,
                                                ),
                                              ),
                                            );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: !allChanged
                                          ? Colours.primaryColourDisabled
                                          : Colours.primaryColour,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
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
                                                color: Colours.secondaryColour),
                                          ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
