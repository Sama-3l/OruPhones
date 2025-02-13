import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/database/models/product_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/home/presentation/widgets/product_card.dart';
import 'package:oruphones/features/home/presentation/widgets/sort_filter_button.dart';

class BestDeals extends StatefulWidget {
  const BestDeals({super.key});

  @override
  State<BestDeals> createState() => _BestDealsState();
}

class _BestDealsState extends State<BestDeals> {
  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "Best Deal Near Your",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: LightColors.titleBlack,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "(India)",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: LightColors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 24,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 36,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            SortFilterButton(
              prefixIcon: sort,
              title: "Sort",
            ),
            SortFilterButton(
              prefixIcon: filter,
              title: "Filter",
            ),
          ]),
        ),
        FutureBuilder<List<ProductModel>>(
          future: func.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading indicator
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}")); // Error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data found")); // No data message
            } else {
              final items = snapshot.data!;
              return GridView.builder(
                padding: EdgeInsets.only(top: 24),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.55,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: items[index]);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
