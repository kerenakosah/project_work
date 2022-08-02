import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class BrandButton extends StatelessWidget {
  final String title;

  const BrandButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 296.0,
      height: 53.0,
      decoration: BoxDecoration(
        color: BrandColors.kButtonColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: BrandColors.kTextColor,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
