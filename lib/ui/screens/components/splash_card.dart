import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class SplashCard extends StatelessWidget {
  final Color backgroundColor;
  final double headingTop;
  final Color textColor;
  final void Function() onTap;

  const SplashCard({
    Key? key,
    required this.backgroundColor,
    required this.headingTop,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(
        milliseconds: 1000,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(
              milliseconds: 1000,
            ),
            margin: EdgeInsets.only(
              top: headingTop,
            ),
            child: Column(
              children: <Widget>[
                IntroText(
                  onTap: onTap,
                  textColor: textColor,
                ),
              ],
            ),
          ),
          const BrandImage(nameImage: Assets.imagesSplashBg),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 53.0,
              width: 296.0,
              decoration: BoxDecoration(
                color: BrandColors.kButtonColor,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: const BrandButton(title: BrandStrings.getStarted),
            ),
          ),
        ],
      ),
    );
  }
}
