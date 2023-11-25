import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/constanst.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

import '../../../../core/common/widgets/rounded_button.dart';

class EmployeeItem extends StatefulWidget {
  final Employee employee;
  final bool isShowCheckBox;
  final bool isCheck;
  final ValueChanged<bool> onChanged;

  const EmployeeItem({
    super.key,
    required this.employee,
    this.isShowCheckBox = false,
    this.isCheck = false,
    required this.onChanged
  });

  @override
  State<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<EmployeeItem> with AutomaticKeepAliveClientMixin{

  late bool check;

  @override
  void initState() {
    check = widget.isCheck;
    super.initState();
  }

  Future showCustomBottomSheet(BuildContext context){
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)
            )
        ),
        context: context,
        builder: (context){
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 27, right: 27, bottom: 56),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Colours.primaryColour,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Yakin Hapus ?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colours.primaryColour
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                            child: RoundedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              text: 'Batal',
                              backgroundColor: Colours.primaryColour,
                            )
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                            child: RoundedButton(
                              onPressed: (){
                                debugPrint('item berhasil dihapus');
                              },
                              text: 'Hapus',
                              backgroundColor: Colours.errorColour,
                            )
                        ),
                      ],
                    ),
                  ],
                )
              ]
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
          children: [
            Visibility(
              visible: widget.isShowCheckBox,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    check = !check;
                    widget.onChanged(check);
                  });
                },
                child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 500),
                    decoration: const BoxDecoration(
                        color: Colours.primaryColour,
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        )
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    height: 28,
                    width: 28,
                    child: check
                        ? Center(child: SvgPicture.asset(MediaRes.checkIcon),)
                        : null
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 96,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Colours.itemCardBorderColour,
                      )
                  ),
                  color: Colours.secondaryColour,
                  shadows: const [
                    BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0
                    )
                  ]
              ),
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
                                image: NetworkImage(widget.employee.photo ?? kDefaultAvatar),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: widget.isShowCheckBox ? 90 : 125,
                            margin: const EdgeInsets.only(right: 10),
                            child: Text(
                              widget.employee.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colours.primaryColour,
                                  fontWeight: FontWeight.w700
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            widget.employee.employeeType,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colours.primaryColour
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          debugPrint('Masuk ke edit');
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  color: Colours.primaryColour,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            SvgPicture.asset(
                              MediaRes.buttonEditIcons,
                              color: Colours.secondaryColour,
                              width: 20,
                              height: 20,)
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: (){
                          showCustomBottomSheet(context);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  color: Colours.errorColour,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            SvgPicture.asset(
                              MediaRes.buttonDeleteIcons,
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
  }

  @override
  bool get wantKeepAlive => true;
}