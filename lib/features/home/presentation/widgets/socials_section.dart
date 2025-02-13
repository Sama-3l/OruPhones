import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';

class SocialsSection extends StatelessWidget {
  const SocialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LightColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 237,
                    color: LightColors.blackGrey,
                  ),
                  Container(
                    height: 237,
                    color: Colors.transparent,
                  ),
                ],
              ),
              Positioned(
                top: 237 * 0.4,
                left: 40,
                right: 40,
                child: Container(
                  decoration: BoxDecoration(color: LightColors.white, borderRadius: BorderRadius.circular(40), boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 12,
                      color: LightColors.shadowColor.withValues(alpha: 0.1),
                    ),
                    BoxShadow(
                      offset: Offset(0, 22),
                      blurRadius: 22,
                      color: LightColors.shadowColor.withValues(alpha: 0.09),
                    ),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          "Invite a friend to ORUphones application. Tap to copy the respective download link to the clipboard",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: LightColors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Image.asset(
                            'lib/assets/images/playStore.png',
                            width: double.infinity,
                          ),
                        ),
                        Image.asset(
                          'lib/assets/images/appStore.png',
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16),
            child: Text(
              "Or Share",
              style: GoogleFonts.poppins(
                fontSize: 12,
                letterSpacing: -0.6,
                color: LightColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'lib/assets/images/socials/instagram.png',
                    width: 40,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 15),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'lib/assets/images/socials/telegram.png',
                      width: 40,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 30),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'lib/assets/images/socials/twitter.png',
                      width: 40,
                    )),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'lib/assets/images/socials/whatsapp.png',
                    width: 40,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
