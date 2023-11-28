import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';

class EditEmployeeForm extends StatefulWidget {
  const EditEmployeeForm({
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
  final GlobalKey<FormState> formKey;

  @override
  State<EditEmployeeForm> createState() => _EditEmployeeFormState();
}

class _EditEmployeeFormState extends State<EditEmployeeForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
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
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.nameController,
              hintText: 'Nama',
            ),
            const SizedBox(height: 25),
            const Text(
              'Email',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
            const SizedBox(height: 25),
            const Text(
              'Telepon',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.phoneController,
              hintText: 'Telepon',
              keyboardType: TextInputType.phone,
              overrideValidator: false,
            ),
            const SizedBox(height: 25),
            const Text(
              'Tanggal Lahir',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.dateOfBirthController,
              hintText: 'Tanggal Lahir',
              keyboardType: TextInputType.datetime,
              overrideValidator: false,
              readOnly: true,
            ),
            const SizedBox(height: 25),
            const Text(
              'Divisi',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.employeeDivisionIdController,
              hintText: 'Divisi',
              keyboardType: TextInputType.number,
              overrideValidator: false,
            ),
            const SizedBox(height: 25),
            const Text(
              'Jenis',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.employeeTypeController,
              hintText: 'Jenis',
              keyboardType: TextInputType.text,
              overrideValidator: false,
            ),
            const SizedBox(height: 25),
            const Text(
              'NIK',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.nikController,
              hintText: 'NIK',
              keyboardType: TextInputType.number,
              overrideValidator: false,
            ),
            const SizedBox(height: 25),
            const Text(
              'Tanggal Mulai Kerja',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.cardStartController,
              hintText: 'Tanggal Mulai Kerja',
              keyboardType: TextInputType.datetime,
              overrideValidator: false,
            ),
            const SizedBox(height: 25),
            const Text(
              'Tanggal Berhenti Kerja',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.cardStopController,
              hintText: 'Tanggal Berhenti Kerja',
              keyboardType: TextInputType.datetime,
              overrideValidator: false,
            ),
            const SizedBox(height: 25),
            const Text(
              'Card Number',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.cardNumberController,
              hintText: 'Card Number',
              keyboardType: TextInputType.number,
              overrideValidator: false,
            ),
          ],
        ));
  }
}
