import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/database/models/location_model.dart';
import 'package:oruphones/core/database/models/product_model.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/home/presentation/widgets/product_card.dart';
import 'package:oruphones/features/home/presentation/widgets/sort_filter_button.dart';

class BestDeals extends StatefulWidget {
  const BestDeals({super.key, required this.userModel});

  final UserModel? userModel;

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
          future: func.fetchProducts(widget.userModel),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GridView.builder(
                padding: EdgeInsets.only(top: 24),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ProductCard(
                      userModel: widget.userModel,
                      product: ProductModel(
                        id: "",
                        deviceCondition: "New",
                        listedBy: "",
                        deviceStorage: "",
                        images: [],
                        defaultImage: "",
                        listingState: "",
                        listingLocation: "",
                        listingLocality: "",
                        listingPrice: "",
                        make: "",
                        marketingName: "",
                        openForNegotiation: true,
                        discountPercentage: 0,
                        verified: true,
                        listingId: "",
                        status: "",
                        verifiedDate: "",
                        listingDate: "",
                        deviceRam: "",
                        warranty: "",
                        imagePath: "",
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        location: LocationModel(id: "", type: "Point", coordinates: []),
                        originalPrice: 0,
                        discountedPrice: 0,
                      ));
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data found"));
            } else {
              final items = snapshot.data!;
              return GridView.builder(
                padding: EdgeInsets.only(top: 24),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: items[index],
                    userModel: widget.userModel,
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
