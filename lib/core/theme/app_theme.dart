import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectwork/index.dart';

class BrandTheme {
  static const _lightFillColor = Colors.black;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      textTheme: _textTheme,
      iconTheme: const IconThemeData(color: BrandColors.white),
      canvasColor: colorScheme.background,
      appBarTheme: const AppBarTheme(
        color: BrandColors.primaryColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: BrandColors.black,
        selectionColor: BrandColors.textSelectionColor,
        selectionHandleColor: BrandColors.primaryColor,
      ),
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: BrandColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: colorScheme.copyWith(
        secondary: colorScheme.primary,
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: BrandColors.primaryColor,
    primaryContainer: BrandColors.primaryColor,
    secondary: BrandColors.secondaryColor,
    secondaryContainer: BrandColors.black,
    background: BrandColors.primaryColor,
    surface: BrandColors.primaryColor,
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: BrandColors.primaryColor,
    primaryContainer: BrandColors.primaryColor,
    secondary: BrandColors.secondaryColor,
    secondaryContainer: BrandColors.black,
    background: BrandColors.primaryColor,
    surface: BrandColors.primaryColor,
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_96,
      color: BrandColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline2: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_60,
      color: BrandColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline3: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_48,
      color: BrandColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline4: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_34,
      color: BrandColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline5: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_24,
      color: BrandColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline6: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_20,
      color: BrandColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_16,
      color: BrandColors.secondaryColor,
      fontWeight: _semiBold,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_14,
      color: BrandColors.secondaryColor,
      fontWeight: _semiBold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_16,
      color: BrandColors.secondaryColor,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_14,
      color: BrandColors.secondaryColor,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    button: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_14,
      color: BrandColors.secondaryColor,
      fontStyle: FontStyle.normal,
      fontWeight: _medium,
    ),
    caption: GoogleFonts.montserrat(
      fontSize: BrandSizes.textSize_12,
      color: BrandColors.white,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
