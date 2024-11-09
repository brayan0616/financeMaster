import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorSeed = Color(0xFFB0F2C2);
const scaffoldBackgroundColor = Color(0xFFF8F7F7); // backgroundColor: const Color(0xFFF5F6F9)


class AppTheme {

  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    colorSchemeSeed: colorSeed,

    ///* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 20 )
    ),

    ///* Scaffold Background Color
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    

    ///* Buttons
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.montserratAlternates()
            .copyWith(fontWeight: FontWeight.w700, fontSize: 18)
          )
      )
    ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      color: scaffoldBackgroundColor,
      titleTextStyle: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black, ),
      centerTitle: true,
      
    )
  );

}