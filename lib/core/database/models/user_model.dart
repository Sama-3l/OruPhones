// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class UserModel {
  final String userName;
  final String email;
  final String profilePicPath;
  final String city;
  final String state;
  final String mobileNumber;
  final bool isAccountExpired;
  final DateTime createdDate;
  final List favListings;
  final List userListings;
  final String userType;
  final bool waOptIn;

  UserModel({
    required this.userName,
    required this.email,
    required this.profilePicPath,
    required this.city,
    required this.state,
    required this.mobileNumber,
    required this.isAccountExpired,
    required this.createdDate,
    required this.favListings,
    required this.userListings,
    required this.userType,
    required this.waOptIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json["userName"],
      email: json["email"],
      profilePicPath: json["profilePicPath"],
      city: json["city"],
      state: json["state"],
      mobileNumber: json["mobileNumber"],
      isAccountExpired: json["isAccountExpired"],
      createdDate: DateFormat("dd/MM/yyyy").parse(json["createdDate"]),
      favListings: json["favListings"], // LIST FIXES
      userListings: json["userListings"], // LIST FIXES
      userType: json["userType"],
      waOptIn: json["WAOptIn"],
    );
  }
}
