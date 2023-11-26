import 'package:flutter/material.dart';
import 'package:port_pass_app/core/common/widgets/container_card.dart';
import 'package:port_pass_app/core/common/widgets/gradient_background.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/res/fonts.dart';
import 'package:port_pass_app/core/res/media_res.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPhotoProfile extends StatefulWidget {
  const EditPhotoProfile({super.key});

  static const routeName = '/edit_photo_profile';

  @override
  State<EditPhotoProfile> createState() => _EditPhotoProfileState();
}

class _EditPhotoProfileState extends State<EditPhotoProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primaryColour,
      ),
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        image: MediaRes.colorBackground,
        child: ContainerCard(
          headerHeight: 60,
          header: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://placekitten.com/104/104',
              width: 104,
              height: 104,
              fit: BoxFit.cover,
            ),
          ),
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Edit Foto Profil",
                  style: TextStyle(
                    color: Colours.primaryColour,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontFamily: Fonts.inter,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.primaryColour,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 96,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              child: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset(
                                  MediaRes.cameraIcon,
                                ),
                              )),
                          const SizedBox(width: 20),
                          const Text(
                            'Kamera',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: Fonts.inter),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.primaryColour,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 96,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              child: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset(
                                  MediaRes.galleryIcon,
                                ),
                              )),
                          const SizedBox(width: 20),
                          const Text(
                            'Galeri',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.primaryColour,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 96,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              child: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset(
                                  MediaRes.profileIcon,
                                ),
                              )),
                          const SizedBox(width: 20),
                          const Text(
                            'Tanpa Foto',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}