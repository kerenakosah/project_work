import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class SplashScreen extends StatefulWidget {
  // page id
  static const String id = BrandStrings.splashScreen;
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    // delay for 3 seconds and navigate to the login screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade400,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF5591F),
              gradient: LinearGradient(
                colors: [
                  Colors.cyan.shade400,
                  Colors.teal.shade400,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              Assets.imagesAppLogo,
            ),
          )
        ],
      ),
    );
  }
}
