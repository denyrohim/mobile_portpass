import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:port_pass_app/src/activity_management/presentation/model/item_model.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_management_app_bar.dart';

class DetailActivityScreen extends StatelessWidget {
  const DetailActivityScreen({super.key});

  static const routeName = '/detail-activity';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ActivityManagementAppBar(
        title: 'Tambah Aktivitas',
      ),
      body: GradientBackground(
          image: MediaRes.colorBackground,
          child: SafeArea(
              child: Center(
            child: Stack(
              children: [
                _DetailActivity(),
                ContainerCard(mediaHeight: 0.6, children: [
                  Column(
                    children: [
                      _ListItems(
                        items: [
                          Item(
                              image: 'assets/icons/flutter.png',
                              name: "sasa",
                              weight: '10 ton'),
                          Item(
                              image: 'assets/icons/flutter.png',
                              name: "ssadasa",
                              weight: '10 ton'),
                          Item(
                              image: 'assets/icons/flutter.png',
                              name: "safdsfsa",
                              weight: '10 ton')
                        ],
                      ),
                    ],
                  )
                ]),
              ],
            ),
          ))),
    );
  }
}

class _ListItems extends StatelessWidget {
  const _ListItems({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          color: Colors.white),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset("assets/icons/qr_button.png"),
              padding: const EdgeInsets.all(10),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Daftar Barang",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF315784)),
            ),
            Text(
              "5 Daftar",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF315784)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          runSpacing: 15,
          children: [
            // ListView.builder(itemCount: items.length,itemBuilder: (BuildContext context, int index) {
            //   return _Item(item: items[index]);
            // }),
            _Item(item: items[0]),
            _Item(item: items[1]),
            _Item(item: items[2]),
            // Text(items[0].name)
          ],
        )
      ]),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.item,
  });

  final Item item;
  @override
  Widget build(BuildContext context) {
    final split = item.weight.split(' ');
    return Container(
      padding: EdgeInsets.all(10),
      height: 112,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 15,
              blurStyle: BlurStyle.outer)
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset("assets/icons/flutter.png"),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF315784)),
              ),
              Text(
                split[0],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF315784)),
              ),
              Text(
                split[1],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF315784)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _DetailActivity extends StatelessWidget {
  const _DetailActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 140,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text("Nama Aktivitas",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Container(
                          child: Text(": Activity",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          child: Text("Nama Kapal",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          width: 27,
                        ),
                        Container(
                          child: Text(": Detail Activity",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text("Jenis Kegiatan",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          width: 29,
                        ),
                        Container(
                          child: Text(": dasdasdsa",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text("Tanggal Dibuat",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          width: 27,
                        ),
                        Container(
                          child: Text(": 18/10/23",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text("Status",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          width: 87,
                        ),
                        Container(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Text(":",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)),
                              Image.asset(
                                "assets/icons/accept_icon.png",
                              ),
                              Text("Disetujui",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
