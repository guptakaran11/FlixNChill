//* Packages
import 'package:flutter/material.dart';

//* Screens
import '../Screens/bottom_nav_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          height: 300,
        ),
      ),
    );
  }
}
