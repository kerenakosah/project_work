import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  static const String id = BrandStrings.splashScreen;
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    // delay for 5 seconds and navigate to the login screen
    Future.delayed(const Duration(seconds: 5), () {
      if (userController.isUserLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, BoardingScreen.id, (route) => false);
      }
    });
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
              baseColor: Colors.black12,
              highlightColor: Colors.white,
              loop: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Image.asset(
                  Assets.imagesAppLogo,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
