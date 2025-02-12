// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/constants/enums.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/auth/business_logic/cubits/otpUpdateCubit/otp_update_cubit.dart';
import 'package:oruphones/features/auth/presentation/screens/change_name.dart';
import 'package:oruphones/features/home/presentation/screens/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    "Verify Mobile No.",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      color: LightColors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text.rich(
                      TextSpan(text: '', children: <InlineSpan>[
                        TextSpan(
                          text: "Please enter the 4 digital verification code sent to your mobile  number ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: LightColors.darkGrey,
                            height: 25.2 / 14,
                          ),
                        ),
                        TextSpan(
                          text: "+91-$phoneNumber ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: LightColors.darkGrey,
                            fontWeight: FontWeight.w600,
                            height: 25.2 / 14,
                          ),
                        ),
                        TextSpan(
                          text: "via ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: LightColors.darkGrey,
                            height: 25.2 / 14,
                          ),
                        ),
                        TextSpan(
                          text: "SMS",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: LightColors.darkGrey,
                            fontWeight: FontWeight.w600,
                            height: 25.2 / 14,
                          ),
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: SizedBox(
                width: 200,
                child: BlocBuilder<OtpUpdateCubit, OtpUpdateState>(
                  builder: (context, state) {
                    return PinCodeTextField(
                      autoFocus: true,
                      controller: controller,
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      cursorColor: LightColors.black,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 300),
                      keyboardType: TextInputType.number,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        color: LightColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 45,
                        activeFillColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                        inactiveColor: otpIncorrect ? LightColors.red : LightColors.placeholder,
                        activeColor: otpIncorrect ? LightColors.red : LightColors.placeholder,
                        selectedColor: otpIncorrect ? LightColors.red : LightColors.placeholder,
                      ),
                      onChanged: (value) {
                        otpIncorrect = false;
                        context.read<OtpUpdateCubit>().onUpdate();
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Didn't receive OTP?",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: LightColors.darkGrey,
                      height: 21 / 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text.rich(
                      TextSpan(text: '', children: <InlineSpan>[
                        TextSpan(
                          text: "Resend OTP ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: LightColors.black,
                            height: 21 / 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: "in 0:23 Sec",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: LightColors.black,
                            height: 21 / 14,
                          ),
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    final response = await func.verifyOTP(context, phoneNumber, controller);
                    if (!(response.$1 == APIFailure.status200)) {
                      otpIncorrect = true;
                      context.read<OtpUpdateCubit>().onUpdate();
                    } else {
                      UserModel user = response.$2!;
                      if (user.userName == "") {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChangeNameScreen(user: user)));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  userModel: user,
                                  isLoggedIn: true,
                                )));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: LightColors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                  child: Text(
                    "Verify OTP",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: LightColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
