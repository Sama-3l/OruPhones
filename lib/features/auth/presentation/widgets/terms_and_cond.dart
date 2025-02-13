// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/features/auth/business_logic/cubits/checkBoxCubit/check_box_cubit.dart';

class TermsAndCondSection extends StatelessWidget {
  TermsAndCondSection({super.key, required this.onTap, required this.acceptTermsAndConditions});

  final Function(bool) onTap;
  bool? acceptTermsAndConditions;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    acceptTermsAndConditions = newValue!;
                    onTap(newValue);
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
    );
  }
}
