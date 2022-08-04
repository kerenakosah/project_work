import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class TwoLineItem extends StatelessWidget {
  final String firstText, secondText;

  const TwoLineItem({
    Key? key,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          firstText,
          style: BrandStyles.titleStyle,
        ),
        Text(
          secondText,
          style: BrandStyles.subTitleStyle,
        ),
      ],
    );
  }
}
