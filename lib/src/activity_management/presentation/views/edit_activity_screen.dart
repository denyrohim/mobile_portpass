import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/enums/update_activity_action.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/add_item_screen.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_form.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_card.dart';
import 'package:provider/provider.dart';

class EditActivityScreen extends StatefulWidget {
  const EditActivityScreen({super.key, required this.activity});

  final dynamic activity;

  static const routeName = '/add-activity';

  @override
  State<EditActivityScreen> createState() => EditdActivityScreenState();
}

class EditdActivityScreenState extends State<EditActivityScreen> {
  late Activity activity;

  final nameController = TextEditingController();
  final shipNameController = TextEditingController();
  final activityTypeController = TextEditingController();
  final activityDateController = TextEditingController();
  final activityHourController = TextEditingController();
  final activityRouteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  bool get nameChanged => activity.name.trim() != nameController.text.trim();
  bool get shipNameChanged =>
      activity.shipName.trim() != shipNameController.text.trim();
  bool get activityTypeChanged =>
      activity.type.trim() != activityTypeController.text.trim();
  bool get activityDateChanged =>
      activity.date.trim() != activityDateController.text.trim();
  bool get activityHourChanged =>
      activity.time.trim() != activityHourController.text.trim();
  bool get activityRouteChanged =>
      (activity.route?.trim() ?? "") != activityRouteController.text.trim();
  bool get itemsChanged {
    if (activity.items.length !=
        context.read<ActivityProvider>().itemsEditActivity.length) return true;
    for (var index = 0; index < activity.items.length; index++) {
      if (activity.items[index].name !=
          context.read<ActivityProvider>().itemsEditActivity[index].name) {
        return true;
      }
      if (activity.items[index].amount !=
          context.read<ActivityProvider>().itemsEditActivity[index].amount) {
        return true;
      }
      if (activity.items[index].unit !=
          context.read<ActivityProvider>().itemsEditActivity[index].unit) {
        return true;
      }
      if (activity.items[index].image !=
          context.read<ActivityProvider>().itemsEditActivity[index].image) {
        return true;
      }
      if (activity.items[index].imagePath !=
          context.read<ActivityProvider>().itemsEditActivity[index].imagePath) {
        return true;
      }
    }
    return false;
  }

  bool get nothingChanged =>
      !nameChanged &&
      !shipNameChanged &&
      !activityTypeChanged &&
      !activityDateChanged &&
      !activityHourChanged &&
      !activityRouteChanged &&
      !itemsChanged;

  void get initController {
    nameController.text = activity.name;
    shipNameController.text = activity.shipName;
    activityTypeController.text = activity.type;
    activityDateController.text = activity.date;
    activityHourController.text = activity.time;
    activityRouteController.text = activity.route ?? "";
    context.read<ActivityProvider>().initItemsEditActivity(activity.items);

    nameController.addListener(() => setState(() {}));
    shipNameController.addListener(() => setState(() {}));
    activityTypeController.addListener(() => setState(() {}));
    activityDateController.addListener(() => setState(() {}));
    activityHourController.addListener(() => setState(() {}));
    activityRouteController.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    activity = widget.activity;
    initController;
    super.initState();
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
    return Consumer<ActivityProvider>(
      builder: (_, activityProvider, __) {
        return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
          listener: (context, state) {
            if (state is ActivityManagementError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is DataAdded) {
              initController;
              CoreUtils.showSnackBar(context, "Data berhasil ditambahkan");
            } else if (state is DataUpdated) {
              activity = state.activity;
              initController;
              CoreUtils.showSnackBar(context, "Data berhasil diubah");
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              appBar: const AppBarCore(
                title: 'Edit Aktivitas',
                isBackButton: true,
              ),
              body: GradientBackground(
                image: MediaRes.colorBackground,
                child: ContainerCard(
                  mediaHeight: 0.9,
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
                        width: 194,
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
                                arguments: "Edit");
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
                          '${activityProvider.itemsEditActivity.length} Daftar',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.inter,
                              color: Colours.primaryColour),
                        ),
                      ],
                    ),
                    activityProvider.itemsEditActivity.isEmpty
                        ? SizedBox(
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
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 10),
                              for (var item
                                  in activityProvider.itemsEditActivity) ...[
                                ItemCard(
                                  index: activityProvider.itemsEditActivity
                                      .indexOf(item),
                                  item: activityProvider.itemsEditActivity[
                                      activityProvider.itemsEditActivity
                                          .indexOf(item)],
                                  isEdit: true,
                                  activityType: "Edit",
                                ),
                                const SizedBox(height: 10),
                              ]
                            ],
                          ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 40,
                          child: IgnorePointer(
                            ignoring:
                                false || state is ActivityManagementLoading,
                            child: ElevatedButton(
                              onPressed: () {
                                initController;
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
                                  ignoring: nothingChanged ||
                                      state is ActivityManagementLoading,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (formKey.currentState?.validate() ??
                                          true) {
                                        context
                                            .read<ActivityManagementBloc>()
                                            .add(
                                              UpdateActivityEvent(
                                                actions: [
                                                  if (nameChanged)
                                                    UpdateActivityAction.name,
                                                  if (shipNameChanged)
                                                    UpdateActivityAction
                                                        .shipName,
                                                  if (activityTypeChanged)
                                                    UpdateActivityAction.type,
                                                  if (activityDateChanged)
                                                    UpdateActivityAction.date,
                                                  if (activityHourChanged)
                                                    UpdateActivityAction.time,
                                                  if (activityRouteChanged)
                                                    UpdateActivityAction.route,
                                                  if (itemsChanged)
                                                    UpdateActivityAction.items,
                                                ],
                                                activity: Activity(
                                                  id: activity.id,
                                                  name: nameController.text,
                                                  shipName:
                                                      shipNameController.text,
                                                  type: activityTypeController
                                                      .text,
                                                  date: activityDateController
                                                      .text,
                                                  time: activityHourController
                                                      .text,
                                                  route: activityRouteController
                                                      .text,
                                                  items: activityProvider
                                                      .itemsEditActivity,
                                                  status: activity.status,
                                                  activityProgress:
                                                      activity.activityProgress,
                                                  qrCode: activity.qrCode,
                                                  isChecked: activity.isChecked,
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
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
