// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/auth/business_logic/cubits/checkBoxCubit/check_box_cubit.dart';
import 'package:oruphones/features/auth/presentation/widgets/input_field.dart';
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Your Phone Number",
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  BlocBuilder<CheckBoxCubit, CheckBoxState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: acceptTermsAndConditions,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: LightColors.indicatorGrey,
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (newValue) {
                            acceptTermsAndConditions = newValue;
                            context.read<CheckBoxCubit>().onUpdate();
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text.rich(TextSpan(text: '', children: <InlineSpan>[
                      TextSpan(
                        text: 'Accept ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: LightColors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'terms and conditions',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: LightColors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ])),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () => func.loginButton(context, controller, acceptTermsAndConditions!),
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
                ))
          ],
        ),
      ),
    );
  }
}
