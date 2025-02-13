import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:oruphones/assets/svgs/svg.dart';
import 'package:oruphones/core/database/models/product_model.dart';
import 'package:oruphones/core/themes/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: LightColors.white,
              border: Border.all(
                color: LightColors.productCardBorder,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: LightColors.productCardShadow.withValues(alpha: 0.1),
                ),
                BoxShadow(
                  offset: Offset(-2, 6),
                  blurRadius: 7,
                  spreadRadius: 0,
                  color: LightColors.productCardShadow.withValues(alpha: 0.09),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'lib/assets/images/sampleProduct.png',
                        image: product.defaultImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                        fadeInDuration: const Duration(milliseconds: 500),
                        placeholderFit: BoxFit.cover,
                      ),
                    ),

                    if (product.openForNegotiation)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3.86, sigmaY: 3.86),
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  color: LightColors.glassmorphicGrey.withValues(
                                alpha: 0.69,
                              )),
                              child: Center(
                                child: Text(
                                  "PRICE NEGOTIABLE",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: LightColors.frostedText,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Heart Icon at the top right
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          // Handle heart tap
                        },
                        child: Icon(
                          Icons.favorite_border, // Use Icons.favorite for filled heart
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),

                    if (product.verified)
                      Positioned(
                        top: 8,
                        child: GestureDetector(
                          onTap: () {
                            // Handle SVG icon tap
                          },
                          child: Iconify(
                            oruVerified,
                            size: 32,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Text(
                  product.marketingName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: LightColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Row(
                  children: [
                    Text(
                      "${product.deviceRam.split(' ')[0]}/${product.deviceStorage.split(' ')[0]}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: LightColors.secondoryInfoGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: LightColors.secondoryInfoGrey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: 4,
                        height: 4,
                      ),
                    ),
                    Text(
                      product.deviceCondition,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: LightColors.secondoryInfoGrey,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Row(
                  children: [
                    Text(
                      product.discountedPrice == 0 ? "₹ ${product.listingPrice}" : "₹ ${product.discountedPrice}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: LightColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (product.discountedPrice != 0) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 2.0),
                        child: Text(
                          "₹ ${product.originalPrice}",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: LightColors.darkGrey,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      Text(
                        "(${product.discountPercentage.round()}%)",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: LightColors.red,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.5, sigmaY: 5.5),
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                        color: LightColors.white3.withValues(
                      alpha: 0.77,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            "${product.listingLocation}, ${product.listingState}",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              letterSpacing: -0.5,
                              color: LightColors.frostedText2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.listingDate,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              letterSpacing: -0.5,
                              color: LightColors.frostedText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
