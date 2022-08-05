import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class OpaqueImage extends StatelessWidget {
  final String imageUrl;

  const OpaqueImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          imageUrl,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.fill,
        ),
        Container(
          color: BrandColors.lPrimaryColorOpacity.withOpacity(0.85),
        ),
      ],
    );
  }
}
