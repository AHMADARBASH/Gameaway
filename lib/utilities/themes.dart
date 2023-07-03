import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map<String, dynamic> themes = {
  'whiteTheme': ThemeData(
    appBarTheme:
        const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    canvasColor: const Color(0xfff2f1f7),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      secondary: Colors.white,
    ),
    fontFamily: GoogleFonts.bebasNeue().fontFamily,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.bebasNeue(color: Colors.black),
      bodySmall: GoogleFonts.bebasNeue(color: Colors.black),
      titleLarge: GoogleFonts.bebasNeue(color: Colors.black),
    ),
    shadowColor: Colors.grey[200]!,
  ),
  'darkTheme': ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900]!),
    canvasColor: const Color(0xff0f1416),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      secondary: Colors.blueGrey[900],
    ),
    fontFamily: GoogleFonts.bebasNeue().fontFamily,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.bebasNeue(color: Colors.white),
      bodySmall: GoogleFonts.bebasNeue(color: Colors.white),
      titleLarge: GoogleFonts.bebasNeue(color: Colors.white),
    ),
    shadowColor: Colors.black.withOpacity(0.05),
  ),
};
