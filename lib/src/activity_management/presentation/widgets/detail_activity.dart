import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailActivity extends StatelessWidget {
  const DetailActivity({
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
                  const Row(
                    children: [
                      Text("Nama Aktivitas",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      SizedBox(
                        width: 24,
                      ),
                      Text(": Activity",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white))
                    ],
                  ),
                  const SizedBox(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
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
                        Text(": Detail Activity",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white))
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Text("Jenis Kegiatan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      SizedBox(
                        width: 29,
                      ),
                      Text(": dasdasdsa",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ],
                  ),
                  const Row(
                    children: [
                      Text("Tanggal Dibuat",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      SizedBox(
                        width: 27,
                      ),
                      Text(": 18/10/23",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Status",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      const SizedBox(
                        width: 87,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(":",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                          SvgPicture.asset(
                            "assets/icons/accept_icon.svg",
                          ),
                          const Text("Disetujui",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white))
                        ],
                      ),
                    ],
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
