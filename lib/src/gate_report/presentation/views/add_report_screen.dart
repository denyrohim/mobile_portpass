import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/detail_section.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/form_file.dart';

class FormReport extends StatefulWidget {
  const FormReport({super.key});

  @override
  State<FormReport> createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> {
  String detail =
      "Lampirkan dokumentasi barang yang dibawa oleh Agen. Gunakan format PNG, JPG, JPEG, atau format gambar lainnya.";
  List<PlatformFile> files = [];
  void updateId(PlatformFile newFile) {
    if (files.length == 2) {
      files.removeAt(0);
    }
    setState(() {
      files.add(newFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaRes.colorBackground,
        child: SafeArea(
            child: Center(
          child: Stack(
            children: [
              ContainerCard(
                mediaHeight: 0.85,
                children: [
                  const DetailSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  FormFile(
                    title: "Lampirkan Surat Mendesak",
                    fileType: const ["pdf"],
                    onChanged: (files) {
                      updateId(files);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormFile(
                      onChanged: (files) {
                        updateId(files);
                      },
                      title: "Unggah Dokumentasi",
                      fileType: const [
                        "jpg",
                        "png",
                        "jpeg",
                        "PNG",
                        "JPG",
                        "pdf"
                      ],
                      detail:
                          "Lampirkan dokumentasi barang yang dibawa oleh Agen. Gunakan format PNG, JPG, JPEG, atau format gambar lainnya."),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 30),
                            backgroundColor: files.length == 2
                                ? const Color(0xff315784)
                                : const Color(0xff315784).withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 30),
                            backgroundColor: files.length == 2
                                ? const Color(0xff315784)
                                : const Color(0xff315784).withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
