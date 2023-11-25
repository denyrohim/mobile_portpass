import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/constanst.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';

class EmployeeItem extends StatelessWidget {
  const EmployeeItem(
    BuildContext context, {
    super.key,
    required this.isShowCheckBox,
    required this.employeeId,
    required this.employees,
  });

  final bool isShowCheckBox;
  final int employeeId;
  final List<Employee> employees;

  @override
  Flex build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        if (isShowCheckBox)
          GestureDetector(
            onTap: () {
              context.read<EmployeeManagementBloc>().add(
                    UpdateCheckBoxEmployeeEvent(
                        employeeId: employeeId, employees: employees),
                  );
            },
            child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 500),
                decoration: const BoxDecoration(
                    color: Colours.primaryColour,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: const EdgeInsets.only(right: 10),
                height: 28,
                width: 28,
                child: employees[employeeId].isChecked
                    ? Center(
                        child: SvgPicture.asset(MediaRes.checkIcon),
                      )
                    : null),
          ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 96,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colours.itemCardBorderColour,
                    )),
                color: Colours.secondaryColour,
                shadows: const [
                  BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0)
                ]),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(employees[employeeId].photo ??
                                  kDefaultAvatar),
                              fit: BoxFit.fill)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employees[employeeId].name,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colours.primaryColour,
                              fontWeight: FontWeight.w700),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          employees[employeeId].employeeType,
                          style: const TextStyle(
                              fontSize: 12, color: Colours.primaryColour),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                IgnorePointer(
                  ignoring: isShowCheckBox,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint('Masuk ke edit');
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  color: isShowCheckBox
                                      ? Colours.primaryColourDisabled
                                      : Colours.primaryColour,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            SvgPicture.asset(
                              MediaRes.buttonEditIcons,
                              colorFilter: const ColorFilter.mode(
                                  Colours.secondaryColour, BlendMode.srcATop),
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          debugPrint('Masuk ke delete');
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  color: isShowCheckBox
                                      ? Colours.errorColourDisabled
                                      : Colours.errorColour,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            SvgPicture.asset(
                              MediaRes.buttonDeleteIcons,
                              colorFilter: const ColorFilter.mode(
                                  Colours.secondaryColour, BlendMode.srcATop),
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
