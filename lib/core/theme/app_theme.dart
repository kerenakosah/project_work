import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwork/index.dart';

class BrandThemes {
  static lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: BrandColors.lightThemePrimaryColor,
      scaffoldBackgroundColor: BrandColors.lightThemeScaffoldBGColor,
      colorScheme: const ColorScheme.light().copyWith(
        primary: BrandColors.primaryColor,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline1: GoogleFonts.sourceSansPro(
          color: BrandColors.lightThemeBigTextColor,
        ),
        headline2: GoogleFonts.sourceSansPro(
          color: BrandColors.lightThemeBigTextColor,
        ),
        headline3: GoogleFonts.sourceSansPro(
          color: BrandColors.lightThemeNormalTextColor,
        ),
        headline4: GoogleFonts.sourceSansPro(
          color: BrandColors.lightThemeNormalTextColor,
        ),
        headline5: GoogleFonts.sourceSansPro(
          color: BrandColors.lightThemeSmallTextColor,
        ),
        headline6: GoogleFonts.sourceSansPro(
          color: BrandColors.lightThemeSmallTextColor,
        ),
        subtitle1: GoogleFonts.sourceSansPro(
          color: BrandColors.lightThemeTextFieldTextColor,
        ),
      ),
      hintColor: BrandColors.lightThemeTextFieldHintColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: BrandColors.lightThemeTextFieldCursorColor,
      ),
    );
  }

  static darkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: BrandColors.darkThemePrimaryColor,
      scaffoldBackgroundColor: BrandColors.darkThemeScaffoldBGColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: BrandColors.primaryColor,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline1: GoogleFonts.sourceSansPro(
          color: BrandColors.darkThemeBigTextColor,
        ),
        headline2: GoogleFonts.sourceSansPro(
          color: BrandColors.darkThemeBigTextColor,
        ),
        headline3: GoogleFonts.sourceSansPro(
          color: BrandColors.darkThemeNormalTextColor,
        ),
        headline4: GoogleFonts.sourceSansPro(
          color: BrandColors.darkThemeNormalTextColor,
        ),
        headline5: GoogleFonts.sourceSansPro(
          color: BrandColors.darkThemeSmallTextColor,
        ),
        headline6: GoogleFonts.sourceSansPro(
          color: BrandColors.darkThemeSmallTextColor,
        ),
        subtitle1: GoogleFonts.sourceSansPro(
          color: BrandColors.darkThemeTextFieldTextColor,
        ),
      ),
      hintColor: BrandColors.darkThemeTextFieldHintColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: BrandColors.darkThemeTextFieldCursorColor,
      ),
    );
  }
}
