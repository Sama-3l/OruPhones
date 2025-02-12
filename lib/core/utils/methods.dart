import 'package:flutter/material.dart';
import 'package:oruphones/core/constants/enums.dart';
import 'package:oruphones/core/database/database_queries.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/features/auth/presentation/screens/otp_screen.dart';

class Methods {
  BackendRepo backendRepo = BackendRepo();

  void loginButton(BuildContext context, TextEditingController controller, bool checkBoxValue) {
    if (checkBoxValue) {
      String phoneNumber = controller.value.text;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpScreen(
                phoneNumber: phoneNumber,
              )));
    }
  }

  Future<
      (
        APIFailure,
        UserModel?
      )> verifyOTP(BuildContext context, String phoneNumber, TextEditingController controller) async {
    int otp = int.parse(controller.value.text);
    int number = int.parse(phoneNumber);
    final response = await backendRepo.callPostMethod('login/otpValidate', {
      "countryCode": 91,
      "mobileNumber": number,
      "otp": otp,
    });
    if (response!.statusCode == 200) {
      UserModel user = UserModel.fromJson(response.data["user"]);
      return (
        APIFailure.status200,
        user,
      );
    } else if (response.statusCode == 401) {
      return (
        APIFailure.status401,
        null
      );
    } else {
      return (
        APIFailure.status400,
        null
      );
    }
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => OtpScreen(
    //           phoneNumber: phoneNumber,
    //         )));
  }
}
