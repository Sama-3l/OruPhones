import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';

class LoginInputField extends StatelessWidget {
  const LoginInputField({
    super.key,
    this.textEditingController,
    required this.padding,
    required this.title,
    this.hintText = "Mobile Number",
    this.prefixIcon = false,
    this.textInputType = TextInputType.number,
    this.maxLength = 10,
  });

  final String title;
  final TextEditingController? textEditingController;
  final EdgeInsets padding;
  final String hintText;
  final bool prefixIcon;
  final TextInputType textInputType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: LightColors.black,
          ),
        ),
        Padding(
          padding: padding,
          child: TextField(
            controller: textEditingController,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: LightColors.black,
              letterSpacing: -0.41,
            ),
            keyboardType: TextInputType.number,
            maxLength: maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
            decoration: InputDecoration(
              hintText: hintText,
              counterText: "",
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: LightColors.placeholder,
                letterSpacing: -0.41,
              ),
              isDense: true,
              filled: true,
              fillColor: LightColors.white,
              contentPadding: EdgeInsets.only(top: 16, bottom: 16),
              prefixIconConstraints: BoxConstraints(maxHeight: 20),
              prefixIcon: prefixIcon
                  ? Padding(
                      padding: EdgeInsets.only(left: 10, right: 7),
                      child: Text(
                        "+91",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: LightColors.darkGrey,
                          letterSpacing: -0.41,
                        ),
                      ))
                  : SizedBox(
                      width: 16,
                    ),
              // filled: true,
              // fillColor: LightColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: LightColors.placeholder, width: 1.0), // Increased width
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: LightColors.placeholder, width: 1.0), // For normal state
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: LightColors.placeholder, width: 1.5), // For focused state
              ),
            ),
          ),
        ),
      ],
    );
  }
}
