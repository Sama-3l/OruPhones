import 'package:oruphones/core/database/models/image_model.dart';
import 'package:oruphones/core/database/models/location_model.dart';

class ProductModel {
  final String id;
  final String deviceCondition;
  final String listedBy;
  final String deviceStorage;
  final List<ImageModel> images;
  final String defaultImage;
  final String listingState;
  final String listingLocation;
  final String listingLocality;
  final String listingPrice;
  final String make;
  final String marketingName;
  final bool openForNegotiation;
  final double discountPercentage;
  final bool verified;
  final String listingId;
  final String status;
  final String verifiedDate;
  final String listingDate;
  final String deviceRam;
  final String warranty;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LocationModel location;
  final int originalPrice;
  final int discountedPrice;
  bool liked;

  ProductModel({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.images,
    required this.defaultImage,
    required this.listingState,
    required this.listingLocation,
    required this.listingLocality,
    required this.listingPrice,
    required this.make,
    required this.marketingName,
    required this.openForNegotiation,
    required this.discountPercentage,
    required this.verified,
    required this.listingId,
    required this.status,
    required this.verifiedDate,
    required this.listingDate,
    required this.deviceRam,
    required this.warranty,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    required this.originalPrice,
    required this.discountedPrice,
    this.liked = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"],
      deviceCondition: json["deviceCondition"],
      listedBy: json["listedBy"],
      deviceStorage: json["deviceStorage"],
      images: (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
      defaultImage: json['defaultImage']['fullImage'],
      listingState: json["listingState"],
      listingLocation: json["listingLocation"],
      listingLocality: json["listingLocality"],
      listingPrice: json["listingPrice"],
      make: json["make"],
      marketingName: json["marketingName"],
      openForNegotiation: json["openForNegotiation"],
      discountPercentage: json["discountPercentage"] == null ? 0.0 : json["discountPercentage"] as double,
      verified: json["verified"] as bool,
      listingId: json["listingId"],
      status: json["status"],
      verifiedDate: json["verifiedDate"],
      listingDate: json["listingDate"],
      deviceRam: json["deviceRam"],
      warranty: json["warranty"],
      imagePath: json["imagePath"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      location: LocationModel.fromJson(json['location']),
      originalPrice: json["originalPrice"] ?? 0,
      discountedPrice: json["discountedPrice"] ?? 0,
    );
  }
}
