import 'dart:convert';
import 'dart:io';

import 'package:port_pass_app/core/res/colours.dart';
import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.primaryColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '**Field tidak boleh kosong';
    } else if (!value.contains('@')) {
      return '**Format email tidak valid';
    } else if (!value.contains('.')) {
      return '**Format email tidak valid';
    } else if (value.contains(' ')) {
      return '**Format email tidak valid';
    }

    return null;
  }

  static String? fileToUriBase64(File? file) {
    if (file == null) {
      return null;
    }
    final filePath = file.path;
    final base64File = base64Encode(file.readAsBytesSync());
    String uriBase64;
    if (filePath.split('/').last.split('.').last == "pdf") {
      uriBase64 = "data:application/pdf;base64,$base64File";
    } else if (filePath.split('/').last.split('.').last == "docx" ||
        filePath.split('/').last.split('.').last == "doc") {
      uriBase64 = "data:application/msword;base64,$base64File";
    } else {
      uriBase64 =
          "data:image/${filePath.split('/').last.split('.').last};base64,$base64File";
    }
    return uriBase64;
  }

  static File? uriBase64ToFile(String? uriBase64, String? fileName,
      {String? extension}) {
    if (uriBase64 == null) {
      return null;
    }
    final base64File = uriBase64.split(',').last;
    final decodedBytes = base64Decode(base64File);
    final file = File('${Directory.systemTemp.path}/$fileName.$extension');
    file.writeAsBytesSync(decodedBytes);
    return file;
  }

  // change string(hex) to string(int)
  static String hexToDec(String hex) {
    var value = hex;
    if (hex.contains('#')) {
      value = hex.replaceAll('#', '');
    }
    return int.parse(value, radix: 16).toString();
  }
}
