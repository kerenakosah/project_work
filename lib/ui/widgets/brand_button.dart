import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class BrandButton extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final Color? titleColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final void Function()? onPressed;

  const BrandButton({
    Key? key,
    required this.title,
    this.buttonColor,
    this.titleColor,
    this.fontSize,
    this.width,
    this.height,
    this.borderRadius,
    this.fontWeight,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? 296.0,
        height: height ?? 53.0,
        decoration: BoxDecoration(
          color: buttonColor ?? BrandColors.kButtonColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 50.0),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: titleColor ?? BrandColors.kTextColor,
              fontSize: fontSize ?? 16.0,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
