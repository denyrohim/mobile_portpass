import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/media_res.dart';

class EmployeeItem extends StatelessWidget {
  final String name;
  final String position;
  final String imageUrl;

  const EmployeeItem({
    super.key,
    required this.name,
    required this.position,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      height: 96,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Colours.itemCardBorderColour,
              )
          ),
          color: Colours.itemCardColour,
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
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.fill
                    )
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: width*0.35,
                    child: Text(
                      name,
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
                    position,
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
              SvgPicture.asset(MediaRes.buttonEditIcons),
              const SizedBox(width: 10),
              SvgPicture.asset(MediaRes.buttonDeleteIcons)
            ],
          )
        ],
      ),
    );
  }
}
