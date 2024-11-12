import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final app_theme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.montserratAlternates().fontFamily
        )
    ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF1D1B19)
  )
);
