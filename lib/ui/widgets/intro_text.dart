import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class IntroText extends StatelessWidget {
  final void Function()? onTap;
  final Color textColor;

  const IntroText({
    Key? key,
    this.onTap,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: Center(
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                AppData.title,
                style: TextStyle(
                  color: textColor,
                  fontFamily: "Nunito-Bold",
                  fontSize: 28.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              AppData.descriptionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
