import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:provider/provider.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  static const routeName = '/add-activity';

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final nikController = TextEditingController();
  final cardStartController = TextEditingController();
  final cardStopController = TextEditingController();
  final cardNumberController = TextEditingController();
  final stillWorkingController = TextEditingController();
  final photoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  // File? pickedImage;

  // // ignore: unused_element
  // Future<void> _pickImage({required String type}) async {
  //   final pickedImageFile = await ImagePicker().pickImage(
  //     source: (type == "camera") ? ImageSource.camera : ImageSource.gallery,
  //     imageQuality: 50,
  //     maxWidth: 150,
  //   );
  //   if (pickedImageFile != null) {
  //     setState(() {
  //       pickedImage = File(pickedImageFile.path);
  //     });
  //   }
  // }

  bool get nameChanged => nameController.text.trim() != "";
  bool get emailChanged => emailController.text.trim() != "";
  bool get phoneChanged => phoneController.text.trim() != "";
  bool get dateOfBirthChanged => dateOfBirthController.text.trim() != "";
  bool get nikChanged => nikController.text.trim() != "";
  bool get cardStartChanged => cardStartController.text.trim() != "";
  bool get cardStopChanged => cardStopController.text.trim() != "";
  bool get cardNumberChanged => cardNumberController.text.trim() != "";
  bool get photoChanged => photoController.text.trim() != "";
  bool get stillWorkingChanged {
    if (cardNumberController.text == "") {
      return stillWorkingController.text.trim() != "true";
    }
    return stillWorkingController.text.trim() != "false";
  }

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !phoneChanged &&
      !dateOfBirthChanged &&
      !nikChanged &&
      !cardStartChanged &&
      !cardStopChanged &&
      !cardNumberChanged &&
      !photoChanged &&
      !stillWorkingChanged;

  void get initController {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    dateOfBirthController.text = "";

    nikController.text = "";
    cardStartController.text = "";
    cardStopController.text = "";
    cardNumberController.text = "";
    stillWorkingController.text = "false";
    photoController.text = "";

    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    dateOfBirthController.addListener(() => setState(() {}));
    nikController.addListener(() => setState(() {}));
    cardStartController.addListener(() => setState(() {}));
    cardStopController.addListener(() => setState(() {}));
    cardNumberController.addListener(() => setState(() {}));
    stillWorkingController.addListener(() => setState(() {}));
    photoController.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    initController;
    // context
    //     .read<ActivityManagementBloc>()
    //     .add(const GetActivityDivisionEvent());
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    nikController.dispose();
    cardStartController.dispose();
    cardStopController.dispose();
    cardNumberController.dispose();
    stillWorkingController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        // if (state is ActivityManagementError) {
        //   CoreUtils.showSnackBar(context, state.message);
        // } else if (state is DataAdded) {
        //   initController;
        //   context.read<FileProvider>().resetAddActivity();
        //   CoreUtils.showSnackBar(context, "Data berhasil ditambahkan");
        // } else if (state is NFCScanSuccess) {
        //   CoreUtils.showSnackBar(
        //       context, "NFC berhasil discan: ${state.nfcNumber}");
        // } else if (state is PhotoAdded) {
        //   // context.read<FileProvider>().initFile(state.photo);
        //   CoreUtils.showSnackBar(context, "Foto berhasil diubah");
        // } else if (state is ActivityDivisionLoaded) {
        //   context
        //       .read<ActivityDivisionProvider>()
        //       .initActivityDivision(state.employeeDivisions);
        // }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
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
          resizeToAvoidBottomInset: true,
          body: GradientBackground(
            image: MediaRes.colorBackground,
            child: SingleChildScrollView(
              reverse: true,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Consumer<FileProvider>(
                  builder: (_, fileProvider, __) {
                    return ContainerCard(
                      mediaHeight: 0.8,
                      headerHeight: 62,
                      children: [
                        const SizedBox(height: 40),
                        // ActivityForm(
                        //   nameController: nameController,
                        //   emailController: emailController,
                        //   phoneController: phoneController,
                        //   dateOfBirthController: dateOfBirthController,
                        //   nikController: nikController,
                        //   cardStartController: cardStartController,
                        //   cardStopController: cardStopController,
                        //   cardNumberController: cardNumberController,
                        //   stillWorkingController: stillWorkingController,
                        //   formKey: formKey,
                        // ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 160,
                              height: 40,
                              child: IgnorePointer(
                                ignoring: nothingChanged
                                // ||
                                //     state is ActivityManagementLoading
                                ,
                                child: ElevatedButton(
                                  onPressed: () {
                                    initController;
                                    context
                                        .read<FileProvider>()
                                        .resetAddActivity();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: nothingChanged
                                        ? Colours.primaryColourDisabled
                                        : Colours.primaryColour,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child:
                                      // state is ActivityManagementLoading
                                      //     ? const Center(
                                      //         child: CircularProgressIndicator())
                                      //     :
                                      const Text(
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
                                      ignoring: nothingChanged
                                      // ||
                                      //     state is ActivityManagementLoading
                                      ,
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
                                          //             id: 0,
                                          //             name: nameController.text
                                          //                 .trim(),
                                          //             email: emailController
                                          //                 .text
                                          //                 .trim(),
                                          //             phone: phoneController
                                          //                 .text
                                          //                 .trim(),
                                          //             dateOfBirth:
                                          //                 dateOfBirthController
                                          //                     .text
                                          //                     .trim(),
                                          //             nik: nikController.text
                                          //                 .trim(),
                                          //             cardStart:
                                          //                 cardStartController
                                          //                     .text
                                          //                     .trim(),
                                          //             cardStop:
                                          //                 cardStopController
                                          //                     .text
                                          //                     .trim(),
                                          //             cardNumber:
                                          //                 cardNumberController
                                          //                     .text
                                          //                     .trim(),
                                          //             photo: fileProvider
                                          //                 .uriAddActivity,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child:
                                            // state
                                            //         is ActivityManagementLoading
                                            //     ? const Center(
                                            //         child:
                                            //             CircularProgressIndicator())
                                            //     :
                                            const Text(
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
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 112,
                        ),
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
