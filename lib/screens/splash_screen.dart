import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectwork/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
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
    return initWidget();
  }

  Widget initWidget() {
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
              "assets/images/app_logo.png",
            ),
          )
        ],
      ),
    );
  }
}
