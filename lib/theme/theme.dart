import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ListOfColors {
  static Color primaryBlack = Color(0xff01D1B19);
  static Color primaryWhite = Colors.white;
  static Color primaryGreen = Color(0xff669D4F);
  static Color primaryOrange = Color(0xffFFA43C);
}

final app_theme = ThemeData(
  fontFamily: 'GoogleFonts.montserrat().fontFamily',
  textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontWeight: FontWeight.w900,
          fontFamily: 'MontserrattAlternates',
          color: Color(0xff01D1B19)
      ),
      headlineSmall: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: 'MontserrattAlternates',
          color: Color(0xff01D1B19),
          fontSize: 16
      ),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'MontserrattAlternates',
          color: Color(0xff01D1B19),
          fontSize: 20
      ),
      displaySmall: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          color: Color(0xff01D1B19),
          fontSize: 16
      )
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ListOfColors.primaryWhite),
        backgroundColor: WidgetStatePropertyAll(ListOfColors.primaryBlack),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),

            )
        ),
      )
  ),
);