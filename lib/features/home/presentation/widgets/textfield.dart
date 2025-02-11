import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/themes/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.textEditingController,
    required this.padding,
  });

  final TextEditingController? textEditingController;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: textEditingController,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: LightColors.darkGrey,
        ),
        decoration: InputDecoration(
          hintText: "Search phones with make, model...",
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: LightColors.darkGrey,
          ),
          isDense: true,
          filled: true,
          fillColor: LightColors.white,
          contentPadding: EdgeInsets.only(top: 16, bottom: 16),
          prefixIconConstraints: BoxConstraints(maxHeight: 20),
          suffixIconConstraints: BoxConstraints(maxHeight: 20),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 1,
                  height: 16,
                  color: LightColors.darkGrey,
                ),
                SizedBox(
                  width: 4,
                ),
                Iconify(
                  mic,
                  size: 16,
                  color: LightColors.darkGrey,
                ),
              ],
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, right: 7),
            child: Icon(
              Icons.search,
              size: 16,
              color: LightColors.lightYellow,
            ),
          ),
          // filled: true,
          // fillColor: LightColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: LightColors.white2, width: 1.0), // Increased width
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: LightColors.white2, width: 1.0), // For normal state
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: LightColors.white2, width: 1.5), // For focused state
          ),
        ),
      ),
    );
  }
}
