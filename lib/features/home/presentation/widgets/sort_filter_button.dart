import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/core/themes/app_colors.dart';

class SortFilterButton extends StatelessWidget {
  const SortFilterButton({super.key, required this.prefixIcon, required this.title});

  final String prefixIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: LightColors.white,
          border: Border.all(color: LightColors.white2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          child: Center(
            child: Row(
              children: [
                Iconify(
                  prefixIcon,
                  size: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 4.0,
                    left: 4.0,
                  ),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: LightColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
