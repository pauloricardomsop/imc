import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primaryColor: const Color(0xFF008CFF),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    // scaffoldBackgroundColor: AppColors.white,
    // iconTheme: const IconThemeData(color: AppColors.green, size: 32),
  );

  static AppText text = AppText();
}

class AppText {
  AppThemeText normal = AppThemeText(FontWeight.w400);
  AppThemeText semi = AppThemeText(FontWeight.w600);
  AppThemeText extra = AppThemeText(FontWeight.w800);
}

class AppThemeText {
  final FontWeight weight;
  AppThemeText(this.weight);

  TextStyle xs([Color? color]) => TextStyle(
        fontSize: 12,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle sm([Color? color]) => TextStyle(
        fontSize: 14,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle base([Color? color]) => TextStyle(
        fontSize: 16,
        height: 1.5,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle lg([Color? color]) => TextStyle(
        fontSize: 18,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl([Color? color]) => TextStyle(
        fontSize: 20,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl2([Color? color]) => TextStyle(
        fontSize: 24,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl3([Color? color]) => TextStyle(
        fontSize: 30,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl4([Color? color]) => TextStyle(
        fontSize: 36,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl5([Color? color]) => TextStyle(
        fontSize: 48,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl6([Color? color]) => TextStyle(
        fontSize: 60,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl7([Color? color]) => TextStyle(
        fontSize: 72,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl8([Color? color]) => TextStyle(
        fontSize: 96,
        fontWeight: weight,
        fontFamily: 'Inter',
        color: color,
      );
  TextStyle xl9([Color? color]) => TextStyle(
        fontSize: 128,
        fontWeight: weight,
        fontFamily: 'Inter',
        // color: color,
      );
}