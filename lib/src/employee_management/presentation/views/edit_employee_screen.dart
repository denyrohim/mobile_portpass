import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({super.key, required this.employee});

  final Employee employee;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
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
  final isCheckedController = TextEditingController();

  File? pickedImage;

  // ignore: unused_element
  Future<void> _pickImage(String type) async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImageFile != null) {
      setState(() {
        pickedImage = File(pickedImageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
