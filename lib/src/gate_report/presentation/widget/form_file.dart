import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FormFile extends StatefulWidget {
  const FormFile({
    super.key,
    required this.title,
    required this.fileType,
    this.detail,
    required this.onChanged,
  });

  final String title;
  final List<String> fileType;
  final String? detail;
  final FileCallback? onChanged;

  @override
  State<FormFile> createState() => _FormFileState();
}

typedef FileCallback = void Function(PlatformFile files);

class _FormFileState extends State<FormFile> {
  bool file1 = false;
  String? fileName1;
  int _file1Size = 0;
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff315784))),
        widget.detail != null
            ? Text(widget.detail!,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff315784)))
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: screenWidth * 0.9 ,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  file1
                      ? Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/accept_icon.svg",
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Berhasil Unggah",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff315784)),
                              ),
                            ],
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Belum ada Unggahan",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff315784)),
                          ),
                        ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff315784)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: widget.fileType,
                      );
                      if (result != null) {
                        final file = result.files.first;
                        final filePickerVal = File(result.files.single.path.toString());
                        debugPrint('File stream: ${filePickerVal.toString()}');
                        setState(() {
                          file1 = true;
                          fileName1 = file.name;
                          _file1Size = file.size;
                        });
                        widget.onChanged!(file);
                        
                        // final file = File(path);
                        // do something with the file
                      }
                    },
                    icon: SvgPicture.asset("assets/icons/unggah_icon.svg"),
                    label: const Text(
                      "Unggah",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        file1
            ? fileName1 != null
                ? Text(
                    '$fileName1 (${(_file1Size / 1000000.0).toStringAsFixed(2)} MB)',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff315784)),
                  )
                : const Text(
                    "Nama dokumen",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff315784)),
                  )
            : const Text(
                "Nama dokumen",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff315784)),
              ),
      ],
    );
  }
}
