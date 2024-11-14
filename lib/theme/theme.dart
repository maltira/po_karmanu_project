import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: const WidgetStatePropertyAll(Color(0xff01D1B19)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),

          )
        ),
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontFamily: GoogleFonts.montserratAlternates().fontFamily,
          fontSize: 16,
          letterSpacing: 1,
          fontWeight: FontWeight.bold
        ))
      )
    )
);
