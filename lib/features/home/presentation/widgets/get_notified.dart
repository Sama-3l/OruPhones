import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';

class GetNotifiedSection extends StatelessWidget {
  const GetNotifiedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222,
      color: LightColors.yellow,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Get Notified About Our \nLatest Offers and Price Drops",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                letterSpacing: -0.8,
                color: LightColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: LightColors.darkGrey,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your email here",
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: LightColors.darkGrey,
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: LightColors.white,
                  contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
                  // suffixIconConstraints: BoxConstraints(maxHeight: 20),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Container(
                      width: 75,
                      decoration: BoxDecoration(
                        color: LightColors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Center(
                          child: Text(
                            "Send",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: LightColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(72),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(72),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(72),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
