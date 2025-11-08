import 'package:afrifounders_notes_app/core/colors/colors.dart';
import 'package:afrifounders_notes_app/core/font_sizes/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.darkBackground,
  useMaterial3: true,
  hintColor: AppColors.darkHintText,
  colorScheme: ColorScheme(
    shadow: AppColors.shadow,
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkSecondary,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkPrimary,
    error: AppColors.error,
    onError: AppColors.darkSecondary,
    surface: AppColors.darkBackground,
    onSurface: AppColors.darkSecondary,
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.nunito(
      fontSize: AppFontSizes.h1.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: AppFontSizes.h2.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
    ),
    headlineSmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.h3.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: AppFontSizes.h4.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
    ),
    displaySmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.h5.sp,
      color: AppColors.darkText,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: AppFontSizes.b1.sp,
      color: AppColors.darkText,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: AppFontSizes.b2.sp,
      color: AppColors.darkText,
    ),
    labelSmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.b3.sp,
      color: AppColors.darkText,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.b4.sp,
      color: AppColors.darkText,
    ),
  ),
);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackground,

  useMaterial3: true,
  hintColor: AppColors.lightHintText,
  colorScheme: ColorScheme(
    shadow: AppColors.shadow,
    brightness: Brightness.light,
    primary: AppColors.lightPrimary,
    onPrimary: AppColors.lightSecondary,
    secondary: AppColors.lightSecondary,
    onSecondary: AppColors.lightPrimary,
    error: AppColors.error,
    onError: AppColors.lightSecondary,
    surface: AppColors.lightBackground,
    onSurface: AppColors.lightSecondary,
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.nunito(
      fontSize: AppFontSizes.h1.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: AppFontSizes.h2.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    headlineSmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.h3.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: AppFontSizes.h4.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    displaySmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.h5.sp,
      color: AppColors.lightText,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: AppFontSizes.b1.sp,
      color: AppColors.lightText,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: AppFontSizes.b2.sp,
      color: AppColors.lightText,
    ),
    labelSmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.b3.sp,
      color: AppColors.lightText,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: AppFontSizes.b4.sp,
      color: AppColors.lightText,
    ),
  ),
);


