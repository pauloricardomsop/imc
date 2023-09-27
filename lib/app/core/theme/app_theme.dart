// import 'package:svr/app/core/theme/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppTheme {
//   static ThemeData theme = ThemeData(
//     primaryColor: const Color(0xFF008CFF),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     brightness: Brightness.light,
//     fontFamily: GoogleFonts.inter().fontFamily,
//   );

//   static AppText text = AppText();
// }

// class AppText {
//   AppThemeText normal = AppThemeText(FontWeight.w400);
//   AppThemeText semi = AppThemeText(FontWeight.w600);
//   AppThemeText extra = AppThemeText(FontWeight.w800);
// }

// class AppThemeText {
//   final FontWeight weight;
//   AppThemeText(this.weight);

//   TextStyle xs([Color? color]) => TextStyle(
//         fontSize: 12,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle sm([Color? color]) => TextStyle(
//         fontSize: 14,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle base([Color? color]) => TextStyle(
//         fontSize: 16,
//         height: 1.5,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle lg([Color? color]) => TextStyle(
//         fontSize: 18,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl([Color? color]) => TextStyle(
//         fontSize: 20,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl2([Color? color]) => TextStyle(
//         fontSize: 24,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl3([Color? color]) => TextStyle(
//         fontSize: 30,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl4([Color? color]) => TextStyle(
//         fontSize: 36,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl5([Color? color]) => TextStyle(
//         fontSize: 48,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl6([Color? color]) => TextStyle(
//         fontSize: 60,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl7([Color? color]) => TextStyle(
//         fontSize: 72,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl8([Color? color]) => TextStyle(
//         fontSize: 96,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle xl9([Color? color]) => TextStyle(
//         fontSize: 128,
//         fontWeight: weight,
//         fontFamily: 'Inter',
//         color: color,
//       );

// // *********** - Config Theme - ***********

//   TextStyle dl([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 57.0,
//         fontWeight: FontWeight.w900,
//         height: 1.12281,
//         letterSpacing: 0,
//         color: color,
//       );
//   TextStyle dm([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 45.0,
//         fontWeight: FontWeight.w900,
//         height: 1.15556,
//         letterSpacing: 0,
//         color: color,
//       );
//   TextStyle ds([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 36.0,
//         fontWeight: FontWeight.w900,
//         height: 1.22222,
//         letterSpacing: 0,
//         color: color,
//       );
//   TextStyle hl([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 32.0,
//         fontWeight: FontWeight.w800,
//         height: 1.25,
//         letterSpacing: 0,
//         color: color,
//       );
//   TextStyle hm([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 28.0,
//         fontWeight: FontWeight.w800,
//         height: 1.28571,
//         letterSpacing: 0,
//         color: color,
//       );
//   TextStyle hs([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 24.0,
//         fontWeight: FontWeight.w800,
//         height: 1.33333,
//         letterSpacing: 0,
//         color: color,
//       );
//   TextStyle tl([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 22.0,
//         fontWeight: FontWeight.w700,
//         height: 1.27273,
//         letterSpacing: 0,
//         color: color,
//       );
//   TextStyle tm([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 16.0,
//         fontWeight: FontWeight.w700,
//         height: 1.5,
//         letterSpacing: 0.15,
//         color: color,
//       );
//   TextStyle ts([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 14.0,
//         fontWeight: FontWeight.w700,
//         height: 1.42857,
//         letterSpacing: 0.1,
//         color: color,
//       );
//   TextStyle ll([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 16.0,
//         fontWeight: FontWeight.w500,
//         height: 1.25,
//         letterSpacing: 0.1,
//         color: color,
//       );
//   TextStyle lm([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 12.0,
//         fontWeight: FontWeight.w500,
//         height: 1.33333,
//         letterSpacing: 0.5,
//         color: color,
//       );
//   TextStyle ls([Color? color]) => TextStyle(
//         fontFamily: 'Inter',
//         fontSize: 11.0,
//         fontWeight: FontWeight.w500,
//         height: 1.45455,
//         letterSpacing: 0.5,
//         color: color,
//       );
//   TextStyle bl([Color? color]) => TextStyle(
//         fontSize: 16.0,
//         fontWeight: FontWeight.w400,
//         height: 1.5,
//         letterSpacing: 0.5,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle bm([Color? color]) => TextStyle(
//         fontSize: 14.0,
//         fontWeight: FontWeight.w400,
//         height: 1.42857,
//         letterSpacing: 0.25,
//         fontFamily: 'Inter',
//         color: color,
//       );
//   TextStyle bs([Color? color]) => TextStyle(
//         fontSize: 12.0,
//         fontWeight: FontWeight.w400,
//         height: 1.33333,
//         letterSpacing: 0.4,
//         fontFamily: 'Inter',
//         color: color,
//       );
// }
