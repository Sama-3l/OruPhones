import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oruphones/core/database/models/user_model.dart';
import 'package:oruphones/core/utils/methods.dart';
import 'package:oruphones/features/auth/presentation/screens/change_name.dart';
import 'package:oruphones/features/home/presentation/screens/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool auth = false;
  UserModel? user;
  final func = Methods();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    func.isLoggedIn((authData, userData) {
      auth = authData;
      user = userData;
    });
    getPermissions();
    _controller.addStatusListener((status) => listenerFunction(status));
  }

  void getPermissions() async {
    await func.requestLocationPermission();
  }

  void listenerFunction(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      if (auth && user!.userName == "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNameScreen(
                    user: user,
                  )),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    isLoggedIn: auth,
                    userModel: user,
                  )),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'lib/assets/animations/Splash.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration; // Set animation duration
            _controller.forward(); // Play animation
          },
        ),
      ),
    );
  }
}
