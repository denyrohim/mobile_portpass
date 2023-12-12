import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/file_provider.dart';
import 'package:port_pass_app/core/common/app/providers/report_provider.dart';
import 'package:port_pass_app/core/common/widgets/app_bar_core.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';
import 'package:port_pass_app/src/gate_report/presentation/bloc/gate_report_bloc.dart';
import 'package:port_pass_app/src/gate_report/presentation/widget/add_report_form.dart';
import 'package:port_pass_app/src/gate_report/presentation/refactor/location_section.dart';
import 'package:provider/provider.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key, required this.activity});

  static const routeName = '/add-report';

  final Activity activity;

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
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

  final urgentLetterController = TextEditingController();
  final documentationController = TextEditingController();
  final locationController = TextEditingController();

  bool get urgentLetterChanged => urgentLetterController.text.trim() != "";
  bool get documentationChanged => documentationController.text.trim() != "";
  bool get locationChanged => locationController.text.trim() != "";

  bool get nothingChanged =>
      !urgentLetterChanged && !documentationChanged && !locationChanged;

  bool get allChanged =>
      urgentLetterChanged && documentationChanged && locationChanged;

  void get initController {
    urgentLetterController.text = "";
    documentationController.text = "";
    locationController.text = "";

    urgentLetterController.addListener(() => setState(() {}));
    documentationController.addListener(() => setState(() {}));
    locationController.addListener(() => setState(() {}));

    context.read<FileProvider>().resetFileAddReport();
    context.read<FileProvider>().resetDocumentationAddReport();
  }

  @override
  void initState() {
    super.initState();
    initController;
  }

  @override
  void dispose() {
    urgentLetterController.dispose();
    documentationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GateReportBloc, GateReportState>(
      listener: (context, state) {
        if (state is GateReportError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is UrgentLetterAdded) {
          context.read<FileProvider>().initFileAddReport(state.file);
          urgentLetterController.text =
              context.read<FileProvider>().fileNameAddReport!;
        } else if (state is DocumentationAdded) {
          context.read<FileProvider>().initDocumentationAddReport(state.photo);
          documentationController.text =
              context.read<FileProvider>().documentationNameAddReport!;
        } else if (state is ReportAdded) {
          CoreUtils.showSnackBar(context, "Laporan berhasil ditambahkan");
          context.read<FileProvider>().resetFileAddReport();
          context.read<FileProvider>().resetDocumentationAddReport();
        } else if (state is LocationLoaded) {
          CoreUtils.showSnackBar(context, "Lokasi berhasil ditambahkan");
          context.read<ReportProvider>().initLocation(state.location);
          locationController.text =
              context.read<ReportProvider>().location!.location;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBarCore(
            title: "Formulir Laporan",
            isBackButton: true,
          ),
          body: GradientBackground(
            image: MediaRes.colorBackground,
            child: Center(
              child: Stack(
                children: [
                  ContainerCard(
                    mediaHeight: 0.85,
                    padding: 10,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const LocationSection(),
                      const SizedBox(
                        height: 10,
                      ),
                      AddReportForm(
                        urgentLetterController: urgentLetterController,
                        documentationController: documentationController,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          IgnorePointer(
                            ignoring:
                                nothingChanged || state is GateReportLoading,
                            child: ElevatedButton(
                              onPressed: () {
                                initController;
                                context
                                    .read<FileProvider>()
                                    .resetFileAddReport();
                                context
                                    .read<FileProvider>()
                                    .resetDocumentationAddReport();
                                context.read<ReportProvider>().resetLocation();
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120, 30),
                                  backgroundColor: !nothingChanged
                                      ? Colours.primaryColour
                                      : Colours.primaryColourDisabled,
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
                          ),
                          IgnorePointer(
                            ignoring: !allChanged || state is GateReportLoading,
                            child: Consumer<ReportProvider>(
                              builder: (_, reportProvider, __) {
                                return ElevatedButton(
                                  onPressed: () {
                                    context.read<GateReportBloc>().add(
                                          AddReportEvent(
                                              activityId: widget.activity.id,
                                              reportData: Report(
                                                urgentLetter: context
                                                    .read<FileProvider>()
                                                    .uriAddReport!,
                                                documentation: context
                                                    .read<FileProvider>()
                                                    .documentationUriAddReport!,
                                                location: reportProvider
                                                    .location!.location,
                                                dateTime: DateTime.now(),
                                              )),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(120, 30),
                                      backgroundColor: allChanged
                                          ? Colours.primaryColour
                                          : Colours.primaryColourDisabled,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: const Text(
                                    "Simpan",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
