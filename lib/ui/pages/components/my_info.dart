import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const RadialProgress(
            width: 4.0,
            goalCompleted: 0.8,
            child: RoundedImage(
              imagePath: Assets.imagesAnne,
              size: Size.fromWidth(120.0),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Keren Akosah",
                style: BrandStyles.whiteNameTextStyle,
              ),
              const SizedBox(width: 4.0),
              Text(
                ", 22",
                style: BrandStyles.whiteNameTextStyle,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Assets.iconsLocationPin,
                width: 20.0,
                color: BrandColors.white,
              ),
              const SizedBox(width: 4.0),
              Text(
                "34 kilometers",
                style: BrandStyles.whiteSubHeadingTextStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}
