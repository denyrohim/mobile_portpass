import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/widgets/i_file.dart';
import 'package:port_pass_app/src/gate_report/presentation/bloc/gate_report_bloc.dart';
import 'package:provider/provider.dart';

class AddReportForm extends StatefulWidget {
  const AddReportForm({
    super.key,
    required this.urgentLetterController,
    required this.documentationController,
  });

  final TextEditingController urgentLetterController;
  final TextEditingController documentationController;

  @override
  State<AddReportForm> createState() => _AddReportFormState();
}

typedef FileCallback = void Function(PlatformFile files);

class _AddReportFormState extends State<AddReportForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FileProvider>(
      builder: (_, fileProvider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Lampirkan Surat Mendesak",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff315784))),
            const SizedBox(
              height: 10,
            ),
            IFile(
              filled: fileProvider.fileAddReport != null,
              fileName: fileProvider.fileNameAddReport,
              fileSize: fileProvider.fileSizeAddReport,
              unitSize: fileProvider.fileUnitSizeAddReport,
              onPressed: () {
                context.read<GateReportBloc>().add(
                      const AddUrgentLetterEvent(),
                    );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Unggah Dokumentasi",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff315784))),
            const Text(
                "Lampirkan dokumentasi barang yang dibawa oleh Agen. "
                "Gunakan format PNG, JPG, JPEG, atau format gambar lainnya.",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff315784))),
            const SizedBox(
              height: 10,
            ),
            IFile(
              filled: fileProvider.documentationAddReport != null,
              fileName: fileProvider.documentationNameAddReport,
              fileSize: fileProvider.documentationSizeAddReport,
              unitSize: fileProvider.documentationUnitSizeAddReport,
              onPressed: () {
                context.read<GateReportBloc>().add(
                      const AddDocumentationEvent(),
                    );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
