import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends ConsumerStatefulWidget {
  // page id
  static const String id = BrandStrings.splashScreen;
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  initState() {
    super.initState();
    // delay for 5 seconds and navigate to the login screen
    Future.delayed(const Duration(seconds: 5), () {
      if (ref.watch(userProvider).isUserLoggedIn) {
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
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
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
