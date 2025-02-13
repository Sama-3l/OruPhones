import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/home/presentation/widgets/faq_tile.dart';

class FaqsSection extends StatelessWidget {
  FaqsSection({super.key});

  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 28.0, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Frequently Asked Questions",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: LightColors.titleBlack,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 24,
            ),
          ],
        ),
      ),
      FutureBuilder<List<Map<String, dynamic>>>(
        future: func.fetchFaqs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}")); // Error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data found")); // No data message
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FaqPanel(question: items[index]["question"], answer: items[index]["answer"]),
              ),
            );
          }
        },
      ),
    ]);
  }
}
