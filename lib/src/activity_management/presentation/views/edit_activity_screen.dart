import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_form.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/activity.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/item_card.dart';
import 'package:provider/provider.dart';

class EditActivityScreen extends StatefulWidget {
  const EditActivityScreen({super.key, required this.activity});

  final Activity activity;

  static const routeName = '/add-activity';

  @override
  State<EditActivityScreen> createState() => EditdActivityScreenState();
}

class EditdActivityScreenState extends State<EditActivityScreen> {
  late Activity activity;
  List<Item>? items;

  final nameController = TextEditingController();
  final shipNameController = TextEditingController();
  final activityTypeController = TextEditingController();
  final activityDateController = TextEditingController();
  final activityHourController = TextEditingController();
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
  bool get itemsChanged => activity.items != items;

  bool get nothingChanged =>
      !nameChanged &&
      !shipNameChanged &&
      !activityTypeChanged &&
      !activityDateChanged &&
      !activityHourChanged &&
      !itemsChanged;

  void get initController {
    nameController.text = activity.name;
    shipNameController.text = activity.shipName;
    activityTypeController.text = activity.type;
    activityDateController.text = activity.date;
    activityHourController.text = activity.time;
    items = activity.items;

    nameController.addListener(() => setState(() {}));
    shipNameController.addListener(() => setState(() {}));
    activityTypeController.addListener(() => setState(() {}));
    activityDateController.addListener(() => setState(() {}));
    activityHourController.addListener(() => setState(() {}));
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is ActivityManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataAdded) {
          initController;
          context.read<FileProvider>().resetAddActivity();
          CoreUtils.showSnackBar(context, "Data berhasil ditambahkan");
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
                          onPressed: () {},
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daftar Barang',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.inter,
                              color: Colours.primaryColour),
                        ),
                        Text(
                          '0 Daftar',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.inter,
                              color: Colours.primaryColour),
                        ),
                      ],
                    ),
                    items!.isEmpty
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
                              for (var item in items!) ...[
                                ItemCard(
                                  item: item,
                                ),
                                SizedBox(height: 10),
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
                            ignoring: nothingChanged ||
                                state is ActivityManagementLoading,
                            child: ElevatedButton(
                              onPressed: () {
                                initController;
                                // context
                                //     .read<ActivityProvider>()
                                //     .resetAddActivity();
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
                                      child: CircularProgressIndicator())
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
                                      // FocusManager.instance.primaryFocus
                                      //     ?.unfocus();
                                      // if (formKey.currentState!
                                      //     .validate()) {
                                      //   context
                                      //       .read<ActivityManagementBloc>()
                                      //       .add(
                                      //         AddActivityEvent(
                                      //           activityData: Activity(
                                      //             name: nameController.text
                                      //                 .trim(),
                                      //             shipName: shipNameController
                                      //                 .text
                                      //                 .trim(),
                                      //             type:
                                      //                 activityTypeController
                                      //                     .text
                                      //                     .trim(),
                                      //             date: activityDateController.text
                                      //                 .trim(),
                                      //             time:
                                      //                 activityHourController
                                      //                     .text
                                      //                     .trim(),

                                      //           ),
                                      //         ),
                                      //       );
                                      // }
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
                              }),
                        ),
                        // ElevatedButton(
                        //   onPressed: (){},
                        //   child: const Row(
                        //     children: [
                        //       Icon(Icons.add),
                        //       Text("Tambah Barang")
                        //     ],
                        //   ),
                        // ),
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
