import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/employee_form.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final employeeDivisionIdController = TextEditingController();
  final employeeTypeController = TextEditingController();
  final nikController = TextEditingController();
  final cardStartController = TextEditingController();
  final cardStopController = TextEditingController();
  final cardNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final key = GlobalKey();

  File? pickedImage;

  // ignore: unused_element
  Future<void> _pickImage({required String type}) async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: (type == "camera") ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImageFile != null) {
      setState(() {
        pickedImage = File(pickedImageFile.path);
      });
    }
  }

  bool get nameChanged => nameController.text.trim() != "";
  bool get emailChanged => emailController.text.trim() != "";
  bool get phoneChanged => phoneController.text.trim() != "";
  bool get dateOfBirthChanged => dateOfBirthController.text.trim() != "";
  bool get employeeDivisionIdChanged =>
      int.parse(employeeDivisionIdController.text) != 0;
  bool get employeeTypeChanged => employeeTypeController.text.trim() != "";
  bool get nikChanged => nikController.text.trim() != "";
  bool get cardStartChanged => cardStartController.text.trim() != "";
  bool get cardStopChanged => cardStopController.text.trim() != "";
  bool get cardNumberChanged => cardNumberController.text.trim() != "";

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !phoneChanged &&
      !dateOfBirthChanged &&
      !employeeDivisionIdChanged &&
      !employeeTypeChanged &&
      !nikChanged &&
      !cardStartChanged &&
      !cardStopChanged &&
      !cardNumberChanged;

  void get initController {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    dateOfBirthController.text = "";
    employeeDivisionIdController.text = "";
    employeeTypeController.text = "";
    nikController.text = "";
    cardStartController.text = "";
    cardStopController.text = "";
    cardNumberController.text = "";

    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    dateOfBirthController.addListener(() => setState(() {}));
    employeeDivisionIdController.addListener(() => setState(() {}));
    employeeTypeController.addListener(() => setState(() {}));
    nikController.addListener(() => setState(() {}));
    cardStartController.addListener(() => setState(() {}));
    cardStopController.addListener(() => setState(() {}));
    cardNumberController.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    initController;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    employeeDivisionIdController.dispose();
    employeeTypeController.dispose();
    nikController.dispose();
    cardStartController.dispose();
    cardStopController.dispose();
    cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
      listener: (context, state) {
        if (state is EmployeeManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        }
        if (state is DataAdded) {
          CoreUtils.showSnackBar(context, "Data berhasil ditambahkan");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colours.primaryColour,
            title: const Text(
              'Tambah Daftar Karyawan',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colours.secondaryColour,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: GradientBackground(
            image: MediaRes.colorBackground,
            child: ContainerCard(
              mediaHeight: 0.7,
              headerHeight: 52,
              header: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 104,
                      height: 104,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                        right: 10,
                      ),
                      color: Colours.secondaryColour,
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
                      onTap: () {},
                      child: Container(
                        width: 30.15,
                        height: 30.15,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colours.primaryColour,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(
                            MediaRes.changePhotoProfileIcon,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                const SizedBox(height: 40),
                EmployeeForm(
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  dateOfBirthController: dateOfBirthController,
                  employeeDivisionIdController: employeeDivisionIdController,
                  employeeTypeController: employeeTypeController,
                  nikController: nikController,
                  cardStartController: cardStartController,
                  cardStopController: cardStopController,
                  cardNumberController: cardNumberController,
                  formKey: formKey,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 40,
                      child: IgnorePointer(
                        ignoring: nothingChanged ||
                            state is EmployeeManagementLoading,
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
                          child: state is EmployeeManagementLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  "Batal",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: Fonts.inter,
                                    color: Colours.secondaryColour,
                                  ),
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
                                state is EmployeeManagementLoading,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (formKey.currentState!.validate()) {
                                  context.read<EmployeeManagementBloc>().add(
                                        const AddEmployeeEvent(
                                          employeeData: Employee(
                                            id: 0,
                                            name: "",
                                            email: "",
                                            phone: "",
                                            dateOfBirth: "",
                                            employeeDivisionId: 0,
                                            employeeType: "",
                                            nik: "",
                                            cardStart: "",
                                            cardStop: "",
                                            cardNumber: "",
                                          ),
                                        ),
                                      );
                                }
                              },
                              child: state is EmployeeManagementLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text(
                                      "Simpan",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: Fonts.inter,
                                        color: Colours.secondaryColour,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
