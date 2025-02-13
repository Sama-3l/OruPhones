// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/core/utils/methods.dart';

class TopBrandsSection extends StatelessWidget {
  TopBrandsSection({super.key});

  // List<int> brands = List.generate(8, (index) => index);
  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Brands",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: LightColors.titleBlack,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 24,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FutureBuilder(
              future: func.fetchBrands(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
                final brands = snapshot.data!;
                return SizedBox(
                  height: 72,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brands.length,
                      itemBuilder: (context, index) => (index != brands.length - 1)
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: index != 0 ? 10 : 0,
                                right: index != brands.length - 1 ? 10 : 0,
                              ),
                              child: Container(
                                height: 72,
                                width: 72,
                                decoration: BoxDecoration(
                                  color: LightColors.brandGrey,
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 16,
                                  ),
                                  child: Image.network(
                                    brands[index],
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: Center(
                                child: Container(
                                  height: 72,
                                  width: 72,
                                  decoration: BoxDecoration(
                                    color: LightColors.brandGrey,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "View All",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: LightColors.blue,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.54,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_right_alt,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                );
              }),
        ),
      ],
    );
  }
}
