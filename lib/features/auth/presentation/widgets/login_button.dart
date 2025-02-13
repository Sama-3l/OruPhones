import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.controller,
    required this.acceptTermsAndConditions,
    this.onTap,
  });

  final TextEditingController controller;
  final bool? acceptTermsAndConditions;
  final Methods func = Methods();
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => func.loginButton(context, controller, acceptTermsAndConditions!, onTap: onTap),
        style: ElevatedButton.styleFrom(
            backgroundColor: LightColors.blue,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Next",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: LightColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Iconify(
                arrow,
                size: 24,
              ),
            )
          ],
        ));
  }
}
