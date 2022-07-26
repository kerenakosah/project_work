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
  // page id
  final String id = 'splash_screen';
  @override
  noSuchMethod(Invocation invocation) {
    startTimer();
    return super.noSuchMethod(invocation);
  }

  startTimer() async {
    Duration duration = const Duration(seconds: 3);
    return Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
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
