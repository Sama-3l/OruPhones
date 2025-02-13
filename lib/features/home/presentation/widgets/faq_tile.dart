import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/features/home/business_logic/cubits/cubit/expand_faq_cubit.dart';

class FaqPanel extends StatefulWidget {
  final String question;
  final String answer;

  FaqPanel({required this.question, required this.answer});

  @override
  _FaqPanelState createState() => _FaqPanelState();
}

class _FaqPanelState extends State<FaqPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpandFaqCubit, ExpandFaqState>(
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: LightColors.faqBorder,
              )),
          color: LightColors.grey2,
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            backgroundColor: LightColors.grey2,
            title: Text(
              widget.question,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: LightColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: Transform.rotate(
                angle: _isExpanded ? 0.785398 : 0, // 0.785398 radians = 45 degrees
                child: Icon(
                  Icons.add,
                  color: LightColors.black,
                ),
              ),
            ),
            onExpansionChanged: (expanded) {
              _isExpanded = expanded;
              context.read<ExpandFaqCubit>().onUpdate();
            },
            children: [
              Container(
                color: LightColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.answer,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: LightColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
