// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class UserModel {
  String userName;
  String email;
  String profilePicPath;
  String city;
  String state;
  String mobileNumber;
  bool isAccountExpired;
  DateTime createdDate;
  List favListings;
  List userListings;
  String userType;
  bool waOptIn;

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
