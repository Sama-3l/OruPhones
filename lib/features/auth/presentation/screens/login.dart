// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/auth/business_logic/cubits/checkBoxCubit/check_box_cubit.dart';
import 'package:oruphones/features/auth/presentation/widgets/input_field.dart';
import 'package:oruphones/features/auth/presentation/widgets/login_button.dart';
import 'package:oruphones/features/auth/presentation/widgets/terms_and_cond.dart';
import 'package:oruphones/features/home/presentation/screens/home.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController controller = TextEditingController();
  bool? acceptTermsAndConditions = false;
  Methods func = Methods();

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              child: LoginInputField(
                prefixIcon: true,
                title: "Enter your Phone Number",
                padding: EdgeInsets.only(top: 4),
                textEditingController: controller,
              ),
            ),
            TermsAndCondSection(
                acceptTermsAndConditions: acceptTermsAndConditions,
                onTap: (value) {
                  acceptTermsAndConditions = value;
                  context.read<CheckBoxCubit>().onUpdate();
                }),
            LoginButton(controller: controller, acceptTermsAndConditions: acceptTermsAndConditions),
          ],
        ),
      ),
    );
  }
}
