import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oruphones/core/database/database_queries.dart';
import 'package:oruphones/features/home/presentation/screens/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool auth = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    isLoggedIn();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    isLoggedIn: auth,
                  )),
        );
      }
    });
  }

  Future<void> isLoggedIn() async {
    BackendRepo backendRepo = BackendRepo();
    final response = await backendRepo.callGetMethod("isLoggedIn");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      auth = data['isLoggedIn'] as bool;
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
