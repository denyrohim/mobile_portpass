import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/widgets/bottom_sheet_widget.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';

class EmployeeConfirmationButton extends StatelessWidget {
  const EmployeeConfirmationButton({
    super.key,
    required this.text,
    this.textStyle,
    required this.textButtonPositive,
    this.colorTextButtonPositive,
    required this.textButtonNegative,
    this.colorTextButtonNegative,
    required this.employeesIds,
  });

  final List<int> employeesIds;
  final String text;
  final TextStyle? textStyle;
  final String textButtonPositive;
  final Color? colorTextButtonPositive;
  final String textButtonNegative;
  final Color? colorTextButtonNegative;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
      listener: (context, state) {
        if (state is EmployeeManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataDeleted) {
          debugPrint('Data Deleted');
          // alert dialog
          AlertDialog(
            title: const Text('Hapus Data'),
            content: const Text('Data berhasil dihapus'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
          context.read<EmployeeManagementBloc>().add(const GetEmployeesEvent());
        }
      },
      builder: (context, state) {
        return BottomSheetWidget(
          height: 200,
          buttonsBottomPosition: 20,
          buttons: [
            RoundedButton(
              onPressed: () {
                final navigator = Navigator.of(context);
                if (navigator.canPop()) {
                  navigator.pop();
                }
              },
              text: textButtonNegative,
              backgroundColor: colorTextButtonNegative,
            ),
            RoundedButton(
              onPressed: () {
                context.read<EmployeeManagementBloc>().add(
                      DeleteEmployeesEvent(employeesIds: employeesIds),
                    );
                final navigator = Navigator.of(context);
                if (navigator.canPop()) {
                  navigator.pop();
                }
              },
              text: textButtonPositive,
              backgroundColor: colorTextButtonPositive,
            ),
          ],
          child: Center(
            child: SizedBox(
              width: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
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
