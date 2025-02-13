import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/constants/enums.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/auth/business_logic/cubits/checkBoxCubit/check_box_cubit.dart';
import 'package:oruphones/features/auth/business_logic/cubits/cubit/bottom_sheet_page_cubit.dart';
import 'package:oruphones/features/auth/business_logic/cubits/otpUpdateCubit/otp_update_cubit.dart';
import 'package:oruphones/features/auth/presentation/widgets/input_field.dart';
import 'package:oruphones/features/auth/presentation/widgets/login_button.dart';
import 'package:oruphones/features/auth/presentation/widgets/terms_and_cond.dart';
import 'package:oruphones/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class BottomSheetLogin extends StatefulWidget {
  const BottomSheetLogin({super.key});

  @override
  _BottomSheetLoginState createState() => _BottomSheetLoginState();
}

class _BottomSheetLoginState extends State<BottomSheetLogin> {
  int _currentPage = 0; // Tracks the current screen
  bool? acceptTermsAndConditions = false;
  bool otpIncorrect = false;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final Methods func = Methods();
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetPageCubit, BottomSheetPageState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _currentPage == 0
              ? _buildLoginScreen(context)
              : _currentPage == 1
                  ? _buildOtpScreen()
                  : _buildNameScreen(),
        );
      },
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the height is based on content
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(color: LightColors.white.withValues(alpha: 0.8), boxShadow: [
            BoxShadow(offset: Offset(0, 2), blurRadius: 2, color: Colors.black.withValues(alpha: 0.06))
          ]),
          child: Row(
            children: [
              Text(
                "Sign in to continue",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: LightColors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    size: 24,
                  ))
            ],
          ),
        ),
        SizedBox(height: 24),
        BlocBuilder<CheckBoxCubit, CheckBoxState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginInputField(
                    textEditingController: phoneNumberController,
                    padding: EdgeInsets.only(top: 4),
                    title: "Enter your Phone Number",
                    prefixIcon: true,
                  ),
                  SizedBox(height: 32),
                  TermsAndCondSection(
                      acceptTermsAndConditions: acceptTermsAndConditions,
                      onTap: (value) {
                        acceptTermsAndConditions = value;
                        context.read<CheckBoxCubit>().onUpdate();
                      }),
                  SizedBox(height: 16),
                  LoginButton(
                    controller: phoneNumberController,
                    acceptTermsAndConditions: acceptTermsAndConditions,
                    onTap: () {
                      _currentPage = 1;
                      context.read<BottomSheetPageCubit>().onPageChange();
                    },
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildOtpScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(color: LightColors.white.withValues(alpha: 0.8), boxShadow: [
            BoxShadow(offset: Offset(0, 2), blurRadius: 2, color: Colors.black.withValues(alpha: 0.06))
          ]),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    _currentPage = 0;
                    acceptTermsAndConditions = false;
                    phoneNumberController.clear();
                    otpController.clear();
                    context.read<CheckBoxCubit>().onUpdate();
                    context.read<BottomSheetPageCubit>().onPageChange();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Transform.rotate(
                      angle: 3.14,
                      child: Iconify(
                        arrow,
                        size: 24,
                        color: LightColors.black,
                      ),
                    ),
                  )),
              Text(
                "Verify OTP",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: LightColors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    size: 24,
                  ))
            ],
          ),
        ),
        SizedBox(height: 24),
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
                text: "+91-${phoneNumberController.value.text} ",
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
        SizedBox(height: 32),
        SizedBox(
          width: 200,
          child: BlocBuilder<OtpUpdateCubit, OtpUpdateState>(
            builder: (context, state) {
              return PinCodeTextField(
                autoFocus: true,
                autoDisposeControllers: false,
                controller: otpController,
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
        SizedBox(height: 32),
        Column(
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
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  final response = await func.verifyOTP(context, phoneNumberController.value.text, otpController);
                  if (!(response.$1 == APIFailure.status200)) {
                    otpIncorrect = true;
                    context.read<OtpUpdateCubit>().onUpdate();
                  } else {
                    user = response.$2!;
                    if (user!.userName == "") {
                      _currentPage = 2;
                      context.read<BottomSheetPageCubit>().onPageChange();
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen()));
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
          ),
        )
      ],
    );
  }

  Widget _buildNameScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(color: LightColors.white.withValues(alpha: 0.8), boxShadow: [
            BoxShadow(offset: Offset(0, 2), blurRadius: 2, color: Colors.black.withValues(alpha: 0.06))
          ]),
          child: Row(
            children: [
              Text(
                "Sign in to continue",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: LightColors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    size: 24,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 32,
            left: 16,
            right: 16,
          ),
          child: LoginInputField(
            padding: EdgeInsets.only(top: 4),
            textEditingController: nameController,
            title: "Please Tell Us Your Name",
            hintText: "Name",
            textInputType: TextInputType.text,
            maxLength: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 24),
          child: ElevatedButton(
              onPressed: () => func.updateUserName(
                    context,
                    nameController.value.text,
                    user!,
                    bottomSheet: true,
                  ),
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
              )),
        )
      ],
    );
  }
}
