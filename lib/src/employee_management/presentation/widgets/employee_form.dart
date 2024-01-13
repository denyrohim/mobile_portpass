import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/employee_division_provider.dart';
import 'package:port_pass_app/core/common/widgets/i_dropdown.dart';
import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/services/injection_container.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee_division.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/calendar_widget.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/scan_nfc_employee_widget.dart';
import 'package:provider/provider.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.dateOfBirthController,
    required this.employeeDivisionIdController,
    required this.employeeTypeController,
    required this.nikController,
    required this.cardStartController,
    required this.cardStopController,
    required this.cardNumberController,
    required this.stillWorkingController,
    required this.formKey,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController dateOfBirthController;
  final TextEditingController employeeDivisionIdController;
  final TextEditingController employeeTypeController;
  final TextEditingController nikController;
  final TextEditingController cardStartController;
  final TextEditingController cardStopController;
  final TextEditingController cardNumberController;
  final TextEditingController stillWorkingController;
  final GlobalKey<FormState> formKey;

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    widget.stillWorkingController.addListener(() => setState(() {}));
    return BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
      listener: (context, state) {
        if (state is EmployeeManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nama',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IFields(
                  controller: widget.nameController,
                  hintText: 'Nama',
                ),
                const SizedBox(height: 12),
                const Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IFields(
                  controller: widget.emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  overrideValidator: true,
                  validator: (value) {
                    return CoreUtils.emailValidator(value);
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'No. HP',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IFields(
                  controller: widget.phoneController,
                  hintText: 'No. HP',
                  keyboardType: TextInputType.phone,
                  overrideValidator: false,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tanggal Lahir',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IFields(
                  controller: widget.dateOfBirthController,
                  hintText: 'DD/MM/YYYY',
                  keyboardType: TextInputType.datetime,
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colours.primaryColour,
                  ),
                  overrideValidator: false,
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return CalendarWidget(
                          dateController: widget.dateOfBirthController,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Bagian',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                Consumer<EmployeeDivisionProvider>(
                  builder: (_, employeeDivisionProvider, __) {
                    return IDropdown(
                      controller: widget.employeeDivisionIdController,
                      hintText: 'Pilih',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.inter,
                        color: Colours.primaryColour,
                      ),
                      fillColor: Colours.secondaryColour,
                      items: [
                        const DropdownMenuItem(
                          value: "Pilih",
                          enabled: false,
                          child: Text(
                            'Pilih',
                            style: TextStyle(
                              color: Colours.primaryColour,
                              fontFamily: Fonts.inter,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const DropdownMenuItem(
                          value: "----",
                          enabled: false,
                          child: Divider(
                            color: Colours.primaryColour,
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        if (employeeDivisionProvider.employeeDivisions != null)
                          for (EmployeeDivision employeeDivision
                              in employeeDivisionProvider.employeeDivisions!)
                            DropdownMenuItem(
                              value: employeeDivision.id.toString(),
                              child: Text(
                                employeeDivision.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: Fonts.inter,
                                  color: Colours.primaryColour,
                                ),
                              ),
                            ),
                      ],
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colours.primaryColour,
                        size: 50,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Jenis Karyawan',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IDropdown(
                  controller: widget.employeeTypeController,
                  hintText: 'Pilih',
                  hintStyle: const TextStyle(
                    color: Colours.primaryColour,
                    fontFamily: Fonts.inter,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  fillColor: Colours.secondaryColour,
                  items: const [
                    DropdownMenuItem(
                      value: "Pilih",
                      enabled: false,
                      child: Text(
                        'Pilih',
                        style: TextStyle(
                          color: Colours.primaryColour,
                          fontFamily: Fonts.inter,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "----",
                      enabled: false,
                      child: Divider(
                        color: Colours.primaryColour,
                        height: 2,
                        thickness: 1,
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Non Organik",
                      child: Text(
                        'Non Organik',
                        style: TextStyle(
                          color: Colours.primaryColour,
                          fontFamily: Fonts.inter,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Organik",
                      child: Text(
                        'Organik',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: Fonts.inter,
                          color: Colours.primaryColour,
                        ),
                      ),
                    ),
                  ],
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colours.primaryColour,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'NIK / No. Batch',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IFields(
                  controller: widget.nikController,
                  hintText: 'NIK / No. Batch',
                  fillColor: Colours.primaryColour,
                  overrideValidator: false,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Mulai Bekerja',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IFields(
                  controller: widget.cardStartController,
                  hintText: 'DD/MM/YYYY',
                  keyboardType: TextInputType.datetime,
                  overrideValidator: false,
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colours.primaryColour,
                  ),
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return CalendarWidget(
                          dateController: widget.cardStartController,
                        );
                      },
                    );
                  },
                ),
                if (widget.stillWorkingController.text == "false") ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Akhir Bekerja',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.inter,
                        color: Colours.primaryColour),
                  ),
                  const SizedBox(height: 10),
                  IFields(
                    controller: widget.cardStopController,
                    hintText: 'DD/MM/YYYY',
                    keyboardType: TextInputType.datetime,
                    overrideValidator: false,
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: Colours.primaryColour,
                    ),
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return CalendarWidget(
                            dateController: widget.cardStopController,
                          );
                        },
                      );
                    },
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.stillWorkingController.text == "true"
                            ? widget.stillWorkingController.text = "false"
                            : widget.stillWorkingController.text = "true";
                        if (widget.stillWorkingController.text == "true") {
                          widget.cardStopController.text = "";
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colours.primaryColour,
                          ),
                          width: 28,
                          height: 28,
                          child: widget.stillWorkingController.text == "true"
                              ? Container(
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colours.secondaryColour,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colours.primaryColour,
                                    size: 20,
                                  ),
                                )
                              : null),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    const Text(
                      'Masih Bekerja Sampai Saat Ini',
                      style: TextStyle(
                        color: Colours.primaryColour,
                        fontFamily: Fonts.inter,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Kartu Akses (NFC)',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.inter,
                      color: Colours.primaryColour),
                ),
                const SizedBox(height: 10),
                IFields(
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return BlocProvider(
                          create: (_) => sl<EmployeeManagementBloc>(),
                          child: ScanNFCEmployeeWidget(
                            cardNumberController: widget.cardNumberController,
                          ),
                        );
                      },
                    );
                  },
                  controller: widget.cardNumberController,
                  hintText: 'ID Kartu (NFC)',
                  keyboardType: TextInputType.number,
                  overrideValidator: false,
                  suffixIcon: SvgPicture.asset(
                    MediaRes.scanSmall,
                  ),
                ),
              ],
            ));
      },
    );
  }
}
