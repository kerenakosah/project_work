import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  // page id
  static const String id = BrandStrings.splashScreen;
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  // open the boarding screen
  void _openBoardingScreen() {
    Navigator.pushNamedAndRemoveUntil(context, BoardingScreen.id, (route) => false);
  }

  @override
  initState() {
    super.initState();
    // delay for 5 seconds and navigate to the login screen
    Future.delayed(const Duration(seconds: 5), _openBoardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Assets.imagesBg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Shimmer.fromColors(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // add a shadow
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.2),
                      blurRadius: 80.0,
                      spreadRadius: 30.0,
                    ),
                  ],
                ),
                child: Image.asset(
                  Assets.imagesAppLogo,
                ),
              ),
              baseColor: Colors.black12,
              highlightColor: Colors.white,
              loop: 6,
            ),
          ),
        ],
      ),
    );
  }
}
