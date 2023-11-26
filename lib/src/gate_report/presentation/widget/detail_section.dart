import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class DetailSection extends StatelessWidget {
  const DetailSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Scan GPS",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff315784),
                  fontSize: 16),
            ),
            RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: IconButton(
                onPressed: (){
                  print("test");
                  
                },
                icon: SvgPicture.asset(
                  'assets/icons/ulangi_icon.svg',
                  height: 20,
                  width: 20,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Color(0xff315784)),
                ),
              ),
            ),
           
          ],
        ),
         const Column(
              children: [
                Row(
                    children: [
                      Text("Latitude",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff315784))),
                      SizedBox(
                        width: 60,
                      ),
                      Text(": Activity",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff315784)))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Longitude",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff315784))),
                      SizedBox(
                        width: 45,
                      ),
                      Text(": Activity",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff315784)))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Lokasi",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff315784))),
                      SizedBox(
                        width: 74,
                      ),
                      Text(": Activity",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff315784)))
                    ],
                  ),
              ],
            ),
      ],
      
    );
  }
}

