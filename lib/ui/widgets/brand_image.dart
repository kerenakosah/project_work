import 'package:flutter/material.dart';

class BrandImage extends StatelessWidget {
  final dynamic nameImage;
  final double? width;
  final double? height;

  const BrandImage({
    Key? key,
    this.nameImage,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 30.0,
      ),
      child: Center(
        child: Image.asset(
          nameImage,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
