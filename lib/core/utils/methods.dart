import 'package:flutter/material.dart';
import 'package:oruphones/core/constants/enums.dart';
import 'package:oruphones/core/database/database_queries.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/features/auth/presentation/screens/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods {
  BackendRepo backendRepo = BackendRepo();

  void loginButton(BuildContext context, TextEditingController controller, bool checkBoxValue) {
    if (checkBoxValue) {
      String phoneNumber = controller.value.text;
      createOtp(phoneNumber);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpScreen(
                phoneNumber: phoneNumber,
              )));
    }
  }

  void createOtp(String phoneNumber) async {
    await backendRepo.callPostMethod('login/otpCreate', {
      "countryCode": 91,
      "mobileNumber": int.parse(phoneNumber),
    });
  }

  Future<void> isLoggedIn(void Function(bool, UserModel?) onTap) async {
    BackendRepo backendRepo = BackendRepo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');
    final response = await backendRepo.callGetMethod("isLoggedIn", cookie: cookie);
    if (response.statusCode == 200) {
      final data = response.data;
      if (data['isLoggedIn'] as bool) {
        onTap(data['isLoggedIn'] as bool, UserModel.fromJson(data['user']));
        prefs.setString("csrfToken", data['csrfToken']);
        prefs.setString("sessionId", data['sessionId']);
      } else {
        onTap(data['isLoggedIn'] as bool, null);
      }
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
    final cookie = response!.headers.map['set-cookie']![0].split(';')[0];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cookie", cookie);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(response.data["user"]);
      isLoggedIn((auth, user) {});
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
  }

  // void updateUserName(String name) async {
  //   final response = await backendRepo.callUserPostMethod('login/otpValidate', {
  //     "countryCode": 91,
  //     "mobileNumber": number,
  //     "otp": otp,
  //   });
  // }
}
