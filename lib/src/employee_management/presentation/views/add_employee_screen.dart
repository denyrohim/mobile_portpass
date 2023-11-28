import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/employee_form.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  static const routeName = '/add-employee';

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colours.primaryColour,
        foregroundColor: Colours.secondaryColour,
        elevation: 0,
        leadingWidth: double.infinity,
        leading: Container(
          margin: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colours.secondaryColour,
                ),
              ),
              const Text(
                'Tambah Daftar Karyawan',
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
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ContainerCard(
                children: [
                  const EmployeeForm(title: 'Nama', hintText: 'Nama'),
                  const EmployeeForm(title: 'Email', hintText: 'Email'),
                  const EmployeeForm(title: 'No. Hp', hintText: 'No. Hp'),
                  const EmployeeForm(
                    title: 'Tanggal Lahir',
                    hintText: 'DD/MM/YYYY',
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colours.primaryColour,
                    ),
                  ),
                  const EmployeeForm(
                    title: 'Bagian',
                    hintText: 'Pilih',
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colours.primaryColour,
                      size: 50,
                    ),
                  ),
                  const EmployeeForm(
                    title: 'Jenis Karyawan',
                    hintText: 'Pilih',
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colours.primaryColour,
                      size: 50,
                    ),
                  ),
                  const EmployeeForm(
                      title: 'NIK / No Batch', hintText: 'NIK / No Batch'),
                  const EmployeeForm(
                    title: 'Mulai Bekerja',
                    hintText: 'DD/MM/YYYY',
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colours.primaryColour,
                    ),
                  ),
                  const EmployeeForm(
                    title: 'Akhir Bekerja',
                    hintText: 'DD/MM/YYYY',
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colours.primaryColour,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                  EmployeeForm(
                    title: 'Kartu Akses (NFC)',
                    hintText: 'ID Kartu NFC',
                    icon: SvgPicture.asset(MediaRes.scanSmall),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedButton(onPressed: () {}, text: 'Batal'),
                      RoundedButton(onPressed: () {}, text: 'Simpan')
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ],
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    width: 104,
                    height: 104,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                    ),
                    width: 30,
                    height: 30,
                  )
                ],
              ),
            ],
          )),
    );
  }
}
