import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/widgets/nested_back_button.dart';
import 'package:port_pass_app/core/enums/update_employee_action.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/edit_employee_form.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({super.key, required this.employee});

  final Employee employee;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late Employee employee;

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
  final stillWorkingController = TextEditingController();
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

  bool get nameChanged => employee.name.trim() != nameController.text.trim();
  bool get emailChanged => employee.email.trim() != emailController.text.trim();
  bool get phoneChanged => employee.phone.trim() != phoneController.text.trim();
  bool get dateOfBirthChanged =>
      employee.dateOfBirth.trim() != dateOfBirthController.text.trim();
  bool get employeeDivisionIdChanged =>
      employee.employeeDivisionId !=
      int.parse(employeeDivisionIdController.text.trim());
  bool get employeeTypeChanged =>
      employee.employeeType.trim() != employeeTypeController.text.trim();
  bool get nikChanged => employee.nik.trim() != nikController.text.trim();
  bool get cardStartChanged =>
      employee.cardStart.trim() != cardStartController.text.trim();
  bool get cardStopChanged =>
      employee.cardStop?.trim() != cardStopController.text.trim();
  bool get cardNumberChanged =>
      employee.cardNumber.trim() != cardNumberController.text.trim();
  bool get photoChanged => pickedImage != null;
  bool get stillWorkingChanged {
    if (employee.cardStop == null) {
      return stillWorkingController.text.trim() != "true";
    }
    return stillWorkingController.text.trim() != "false";
  }

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
      !cardNumberChanged &&
      !photoChanged &&
      !stillWorkingChanged;

  void get initController {
    nameController.text = employee.name.trim();
    emailController.text = employee.email.trim();
    phoneController.text = employee.phone.trim();
    dateOfBirthController.text = employee.dateOfBirth.trim();
    employeeDivisionIdController.text = employee.employeeDivisionId.toString();
    employeeTypeController.text = employee.employeeType.trim();
    nikController.text = employee.nik.trim();
    cardStartController.text = employee.cardStart.trim();
    cardStopController.text = employee.cardStop?.trim() ?? "";
    cardNumberController.text = employee.cardNumber.trim();
    stillWorkingController.text = employee.cardStop == null ? "true" : "false";

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
    stillWorkingController.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    employee = widget.employee;
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
    stillWorkingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
      listener: (context, state) {
        if (state is EmployeeManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataUpdated) {
          employee = state.employee;
          CoreUtils.showSnackBar(context, "Data berhasil diubah");
        } else if (state is NFCScanSuccess) {
          CoreUtils.showSnackBar(
              context, "NFC berhasil discan: ${state.nfcNumber}");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colours.primaryColour,
            leading: const NestedBackButton(),
            title: const Text(
              "Edit Karyawan",
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
                    child: employee.photo != null
                        ? Image.network(
                            employee.photo!,
                            width: 104,
                            height: 104,
                            fit: BoxFit.cover,
                          )
                        : ClipRRect(
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
                  ),
                ],
              ),
              children: [
                const SizedBox(height: 40),
                EditEmployeeForm(
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
                  stillWorkingController: stillWorkingController,
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
                              ? const Center(child: CircularProgressIndicator())
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
                                  state is EmployeeManagementLoading,
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (formKey.currentState!.validate()) {
                                    context.read<EmployeeManagementBloc>().add(
                                          UpdateEmployeeEvent(
                                            actions: [
                                              if (nameChanged)
                                                UpdateEmployeeAction.name,
                                              if (emailChanged)
                                                UpdateEmployeeAction.email,
                                              if (phoneChanged)
                                                UpdateEmployeeAction.phone,
                                              if (dateOfBirthChanged)
                                                UpdateEmployeeAction
                                                    .dateOfBirth,
                                              if (employeeDivisionIdChanged)
                                                UpdateEmployeeAction
                                                    .employeeDivisionId,
                                              if (employeeTypeChanged)
                                                UpdateEmployeeAction
                                                    .employeeType,
                                              if (nikChanged)
                                                UpdateEmployeeAction.nik,
                                              if (cardStartChanged)
                                                UpdateEmployeeAction.cardStart,
                                              if (cardStopChanged)
                                                UpdateEmployeeAction.cardStop,
                                              if (cardNumberChanged)
                                                UpdateEmployeeAction.cardNumber,
                                            ],
                                            employee: Employee(
                                              id: employee.id,
                                              name: nameController.text.trim(),
                                              email:
                                                  emailController.text.trim(),
                                              phone:
                                                  phoneController.text.trim(),
                                              dateOfBirth: dateOfBirthController
                                                  .text
                                                  .trim(),
                                              employeeDivisionId: int.parse(
                                                  employeeDivisionIdController
                                                      .text
                                                      .trim()),
                                              employeeType:
                                                  employeeTypeController.text
                                                      .trim(),
                                              nik: nikController.text.trim(),
                                              cardStart: cardStartController
                                                  .text
                                                  .trim(),
                                              cardStop: cardStopController.text
                                                  .trim(),
                                              cardNumber: cardNumberController
                                                  .text
                                                  .trim(),
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
                                child: state is EmployeeManagementLoading
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
                    )
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
