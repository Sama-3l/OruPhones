import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones/core/constants/enums.dart';
import 'package:oruphones/core/constants/home_page_constants.dart';
import 'package:oruphones/core/database/database_queries.dart';
import 'package:oruphones/core/database/models/product_model.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/features/auth/presentation/screens/otp_screen.dart';
import 'package:oruphones/features/auth/presentation/widgets/login_bottom_sheet.dart';
import 'package:oruphones/features/home/presentation/screens/home.dart';
import 'package:oruphones/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods {
  BackendRepo backendRepo = BackendRepo();

  void loginButton(BuildContext context, TextEditingController controller, bool checkBoxValue, {void Function()? onTap}) {
    if (checkBoxValue) {
      String phoneNumber = controller.value.text;
      if (phoneNumber.length == 10) {
        createOtp(phoneNumber);
        if (onTap != null) {
          onTap();
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OtpScreen(
                    phoneNumber: phoneNumber,
                  )));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Invalid phone number',
          style: GoogleFonts.poppins(
            fontSize: 12,
          ),
        )));
      }
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

  void updateUserName(BuildContext context, String name, UserModel user, {bool bottomSheet = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('csrfToken') ?? "";
    final cookie = prefs.getString('cookie') ?? "";
    final response = await backendRepo.callUserPostMethod(
        'update',
        {
          "countryCode": 91,
          "userName": name,
        },
        token,
        cookie);
    if (response.statusCode == 200) {
      user.userName = name;
      if (bottomSheet) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(
                  isLoggedIn: true,
                  userModel: user,
                )));
      }
    } else {}
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('csrfToken') ?? "";
    final cookie = prefs.getString('cookie') ?? "";
    final response = await backendRepo.callUserGetMethod('logout', token, cookie);
    if (response.statusCode == 200) {
      prefs.clear();
    }
  }

  Future<List<ProductModel>> fetchProducts(UserModel? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('csrfToken') ?? "";
    final cookie = prefs.getString('cookie') ?? "";
    final response = await backendRepo.callUserPostMethod(
        'filter',
        {
          "filter": {}
        },
        token,
        cookie);
    List<ProductModel> products = (response.data["data"]["data"] as List).map((e) => ProductModel.fromJson(e)).toList();
    if (user != null) {
      for (var product in products) {
        product.liked = user.favListings.contains(product.listingId);
      }
    }
    for (int i = 6; i < products.length; i += 7) {
      products.insert(i, dummyProduct);
    }
    return products;
  }

  Future<List<String>> fetchBrands() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie') ?? "";
    final response = await backendRepo.callGetMethod('makeWithImages', cookie: cookie);
    List<String> brands = (response.data["dataObject"] as List).map((e) => e["imagePath"] as String).toList();
    return brands;
  }

  Future<List<Map<String, dynamic>>> fetchFaqs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie') ?? "";
    final response = await backendRepo.callGetMethod('faq', cookie: cookie);
    List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(response.data["FAQs"]);
    return products;
  }

  void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BottomSheetLogin(),
      backgroundColor: Colors.white,
      useSafeArea: true,
    );
  }

  void likeProduct(ProductModel product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('csrfToken') ?? "";
    final cookie = prefs.getString('cookie') ?? "";
    await backendRepo.callUserPostMethod(
        'favs',
        {
          "listingId": product.listingId,
          "isFav": product.liked,
        },
        token,
        cookie);
  }

  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
