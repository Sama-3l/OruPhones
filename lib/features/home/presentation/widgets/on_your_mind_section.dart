import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/constants/home_page_constants.dart';
import 'package:oruphones/core/themes/app_colors.dart';

class OnYourMindSection extends StatelessWidget {
  const OnYourMindSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Text(
            "What's on your mind?",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: LightColors.titleBlack,
            ),
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: options.length,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index != 0 ? 4 : 0,
                      right: index != options.length - 1 ? 4 : 0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: SizedBox(
                        width: 72,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'lib/assets/images/options/option-${index + 1}.png',
                              ),
                              Expanded(
                                child: Text(
                                  options[index],
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: LightColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
