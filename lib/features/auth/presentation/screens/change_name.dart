// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/auth/presentation/widgets/input_field.dart';
import 'package:oruphones/features/home/presentation/screens/home.dart';

class ChangeNameScreen extends StatelessWidget {
  ChangeNameScreen({super.key, this.user});

  final UserModel? user;

  final Methods func = Methods();

  final TextEditingController controller = TextEditingController();

  bool otpIncorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.white,
      appBar: AppBar(
        backgroundColor: LightColors.white,
        elevation: 0,
        toolbarHeight: 50,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen(isLoggedIn: false)),
                  ),
              icon: Icon(
                Icons.close,
                size: 32,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'lib/assets/images/logo.jpg',
              height: 61,
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      color: LightColors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Sign in to continue",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: LightColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please Tell Us Your Name",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: LightColors.black,
                    ),
                  ),
                  LoginInputField(
                    padding: EdgeInsets.only(top: 4),
                    textEditingController: controller,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {},
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
                      "Confirm Name",
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
                ))
          ],
        ),
      ),
    );
  }
}
