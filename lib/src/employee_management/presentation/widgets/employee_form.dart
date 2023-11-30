import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/widgets/i_fields.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';

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
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
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
            IFields(
              controller: widget.employeeDivisionIdController,
              hintText: 'Pilih',
              keyboardType: TextInputType.number,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colours.primaryColour,
                size: 50,
              ),
              overrideValidator: false,
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
            IFields(
              controller: widget.employeeTypeController,
              hintText: 'Pilih',
              keyboardType: TextInputType.text,
              overrideValidator: false,
              suffixIcon: const Icon(Icons.arrow_drop_down,
                  color: Colours.primaryColour, size: 50),
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
              keyboardType: TextInputType.number,
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
            ),
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
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colours.primaryColour,
                  ),
                  width: 28,
                  height: 28,
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
  }
}
