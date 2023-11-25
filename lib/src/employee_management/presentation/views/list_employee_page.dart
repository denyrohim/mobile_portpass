import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/common/views/loading_view.dart';
import 'package:port_pass_app/core/common/widgets/rounded_button.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/constanst.dart';
import 'package:port_pass_app/src/employee_management/domain/entities/employee.dart';

import '../widgets/employee_item.dart';
import '../widgets/menu_item_list.dart';
import '../widgets/search_bar.dart';

class ListEmployeeScreen extends StatefulWidget {
  const ListEmployeeScreen({super.key});

  static const routeName = '/list-employee';

  @override
  State<ListEmployeeScreen> createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {

  List<Employee> dataDummy = [];

  int count = 0;
  int countCheck = 0;

  bool isLoading = true;
  bool isShowCheckBox = false;
  bool isAllChecked = false;

  String searchQuery = '';

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
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Yakin Hapus',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colours.primaryColour
                        ),
                      ),
                      Text(
                        '$countCheck Daftar?',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colours.primaryColour
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: RoundedButton(
                            onPressed: (){
                              Navigator.pop(context);
                              setState(() {
                                isShowCheckBox = false;
                                countCheck = 0;
                              });
                            },
                            text: 'Batal',
                            backgroundColor: Colours.primaryColour,
                          )
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: RoundedButton(
                            onPressed: (){
                              debugPrint('Hapus');
                            },
                            text: 'Hapus',
                            backgroundColor: Colours.errorColour,
                          )
                      ),
                    ],
                  ),
                ]
            ),
          );
        }
    );
  }

  List<Employee> generate(){
    List<Employee> dataDummy = [];

    for(int i = 0; i < 10; i++){
      Employee data = Employee(
          id: i+1,
          name: 'Maisan Auliya $i',
          email: 'maisanaulia02@gmail.com',
          phone: '08123456789',
          dateOfBirth: '1010',
          employeeDivisionId: i,
          employeeType: 'Tester $i',
          nik: '1234567890',
          cardStart: '101001010',
          cardNumber: '1279719797917',
          photo: kDefaultAvatar
      );

      dataDummy.add(data);
    }

    return dataDummy;
  }

  _ListEmployeeScreenState(){
    dataDummy = generate();
  }

  void _onSelectedItem(int value){
    if(value == 1){
      setState(() {
        isShowCheckBox = true;
        isAllChecked = false;
      });
    } else if(value == 2){
      setState(() {
        isShowCheckBox = true;
        isAllChecked = true;
        countCheck = dataDummy.length;
      });
    }
  }

  void _onSearch(String query){
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        isLoading = false;
      });
    });

    count = dataDummy.length;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? const LoadingView()
          : Container(
          color: Colours.primaryColour,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Karyawan',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      isShowCheckBox
                      ? Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '$countCheck Terpilih',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showCustomBottomSheet(context),
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
                      : Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '$count Daftar',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          PopupMenuButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              itemBuilder: (context) => [
                                buildPopMenuItem('Pilih', 1),
                                buildPopMenuItem('Pilih Semua', 2)
                              ],
                              offset: const Offset(0.0, 18),
                              onSelected: (value){
                                _onSelectedItem(value as int);
                              },
                              child: SvgPicture.asset(MediaRes.moreIcons)
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: CustomSearchBar(onSearch: _onSearch,)
                  )
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colours.secondaryColour,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: dataDummy.length,
                        itemBuilder: (context, index){
                          final employee = dataDummy[index];

                          if(employee.name.toLowerCase().contains(searchQuery)) {
                            return EmployeeItem(
                              employee: employee,
                              isShowCheckBox: isShowCheckBox,
                              isCheck: isAllChecked,
                              onChanged: (isChecked){
                                if(isChecked){
                                  setState(() {
                                    countCheck += 1;
                                  });
                                } else if(!isChecked){
                                  setState(() {
                                    countCheck -= 1;
                                  });
                                }
                              }
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
