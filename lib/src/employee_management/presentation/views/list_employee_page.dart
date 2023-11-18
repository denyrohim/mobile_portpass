import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/common/views/loading_view.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/core/utils/constanst.dart';

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

  List<Widget> employeeDummy = [];
  List<Widget> displayedItems = [];
  int count = 0;
  bool isLoading = true;
  String searchQuery = '';

  List<String> menuItems = [
    'Pilih',
    'Pilih Semua'
  ];

  void generateDummy(){
    for(int i = 0; i < 10; i++){
      employeeDummy.add(
          EmployeeItem(
              name: 'Maisan Auliya $i',
              position: 'Tester $i',
              imageUrl: kDefaultAvatar
          )
      );
    }
    displayedItems.addAll(employeeDummy);
  }

  void _onSelectedItem(int value){
    if(value == 1){
      debugPrint('ini pilih');
    } else if(value == 2){
      debugPrint('ini pilih semua');
    }
  }

  void _onSearch(String query){
    setState(() {
      searchQuery = query.toLowerCase();
      displayedItems = employeeDummy.where((element) {
        final employeeName = (element as EmployeeItem).name.toLowerCase();
        return employeeName.contains(searchQuery);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    generateDummy();
    Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        isLoading = false;
      });
    });

    count = employeeDummy.length;
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
                      Row(
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
                                buildPopMenuItem(menuItems[0], 1),
                                buildPopMenuItem(menuItems[1], 2)
                              ],
                              offset: const Offset(0.0, 18),
                              onSelected: (value){
                                _onSelectedItem(value as int);
                              },
                              child: SvgPicture.asset(MediaRes.moreIcons)
                          )
                        ],
                      )
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
              child: ContainerCard(
                  mediaHeight: MediaQuery.of(context).size.height * 0.7,
                  children: displayedItems
              ),
            ),
          ],
        ),
      ),
    );
  }
}
