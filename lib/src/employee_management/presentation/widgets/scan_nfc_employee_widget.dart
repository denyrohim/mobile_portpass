import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_widget.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';

class ScanNFCEmployeeWidget extends StatelessWidget {
  const ScanNFCEmployeeWidget({super.key, required this.cardNumberController});

  final TextEditingController cardNumberController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
      listener: (context, state) async {
        final navigator = Navigator.of(context);
        if (state is NFCScanSuccess) {
          cardNumberController.text = state.nfcNumber;
          await Future.delayed(const Duration(seconds: 2));
          if (navigator.canPop()) {
            navigator.pop();
          }
        }
        if (state is NFCScanFailed) {
          await Future.delayed(const Duration(seconds: 2));
          if (navigator.canPop()) {
            navigator.pop();
          }
        }
      },
      builder: (context, state) {
        return BottomSheetWidget(
          height: 580,
          buttons: !(state is NFCScanSuccess ||
                  state is NFCScanFailed ||
                  state is EmployeeManagementLoading)
              ? [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<EmployeeManagementBloc>(context)
                          .add(const ScanNFCEmployeeEvent());
                    },
                    child: Container(
                      width: 280,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colours.primaryColour,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Scan Sekarang',
                          style: TextStyle(
                              color: Colours.secondaryColour,
                              fontFamily: Fonts.inter,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]
              : [],
          child: (state is EmployeeManagementLoading)
              ? Center(
                  child: Container(
                    width: 240,
                    height: 282,
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      color: Colours.secondaryColour,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colours.primaryColour.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colours.secondaryColour,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colours.primaryColour.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            MediaRes.loadingNFCIcon,
                            width: 118,
                            height: 132,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        const Text(
                          'Proses Scan...',
                          style: TextStyle(
                              color: Colours.primaryColour,
                              fontFamily: Fonts.inter,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              : (state is NFCScanSuccess)
                  ? Center(
                      child: Container(
                        width: 240,
                        height: 282,
                        margin: const EdgeInsets.only(bottom: 50),
                        decoration: BoxDecoration(
                          color: Colours.secondaryColour,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colours.primaryColour.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 28,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colours.secondaryColour,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colours.primaryColour.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                MediaRes.successNFCIcon,
                                width: 118,
                                height: 132,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              'Scan Berhasil',
                              style: TextStyle(
                                  color: Colours.primaryColour,
                                  fontFamily: Fonts.inter,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  : (state is NFCScanFailed)
                      ? Center(
                          child: Container(
                            width: 240,
                            height: 282,
                            margin: const EdgeInsets.only(bottom: 50),
                            decoration: BoxDecoration(
                              color: Colours.secondaryColour,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colours.primaryColour.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 28,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colours.secondaryColour,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colours.primaryColour
                                            .withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    MediaRes.failedNFCIcon,
                                    width: 118,
                                    height: 132,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                const Text(
                                  'Scan Gagal',
                                  style: TextStyle(
                                      color: Colours.primaryColour,
                                      fontFamily: Fonts.inter,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: 240,
                            height: 282,
                            margin: const EdgeInsets.only(bottom: 50),
                            decoration: BoxDecoration(
                              color: Colours.secondaryColour,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colours.primaryColour.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 28,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colours.secondaryColour,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colours.primaryColour
                                            .withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    MediaRes.scanNFCIcon,
                                    width: 118,
                                    height: 132,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                const Text(
                                  'Tempelkan Kartu Anda',
                                  style: TextStyle(
                                      color: Colours.primaryColour,
                                      fontFamily: Fonts.inter,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
        );
      },
    );
  }
}
