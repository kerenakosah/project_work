import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwork/index.dart';

class TransparentButton extends StatelessWidget {
  final String title;

  const TransparentButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 296.0,
      height: 53.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.nunito(
            color: BrandColors.kButtonColor,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
