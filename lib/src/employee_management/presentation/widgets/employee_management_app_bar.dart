import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/common/app/providers/employees_provider.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/employee_confirmation_button.dart';
import 'package:port_pass_app/core/common/widgets/pop_up_item.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';

class EmployeeManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const EmployeeManagementAppBar({
    super.key,
    required this.count,
    required this.employeesProvider,
  });

  final int count;
  final EmployeesProvider employeesProvider;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colours.primaryColour,
      foregroundColor: Colours.secondaryColour,
      title: const Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Daftar Karyawan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      actions: [
        (employeesProvider.isShowChecked)
            ? Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Text(
                      '${employeesProvider.countEmployeeChecked} Terpilih',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: GestureDetector(
                      onTap: () {
                        debugPrint('delete di klik');
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return EmployeeConfirmationButton(
                              text: 'Yakin hapus semua daftar?',
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colours.primaryColour,
                                fontWeight: FontWeight.w700,
                              ),
                              textButtonNegative: 'Batal',
                              textButtonPositive: 'Hapus',
                              colorTextButtonNegative: Colours.primaryColour,
                              colorTextButtonPositive: Colours.errorColour,
                              employeesIds:
                                  employeesProvider.idCheckedEmployees,
                            );
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: Colours.errorColour,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SvgPicture.asset(
                            MediaRes.buttonDeleteIcons,
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        context.read<EmployeeManagementBloc>().add(
                            CancelCheckBoxEmployeeEvent(
                                employees: employeesProvider.employees!));
                        employeesProvider.setShowChecked(false);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: Colours.primaryColour,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          const Icon(
                            Icons.close_rounded,
                            color: Colours.secondaryColour,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Text(
                    '$count Daftar',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: PopupMenuButton(
                      offset: const Offset(0, 50),
                      icon: SvgPicture.asset(MediaRes.moreIcons),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: 1,
                          child: const PopUpItem(
                            title: 'Pilih',
                          ),
                          onTap: () {
                            debugPrint('item pilih di klik');
                            employeesProvider.setShowChecked(true);
                          },
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: const PopUpItem(
                            title: 'Pilih Semua',
                          ),
                          onTap: () {
                            debugPrint('item pilih semua di klik');
                            context.read<EmployeeManagementBloc>().add(
                                SelectAllEmployeesEvent(
                                    employees: employeesProvider.employees!));
                            employeesProvider.setShowChecked(true);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
