import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeData {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    textTheme: GoogleFonts.montserratTextTheme(),
    useMaterial3: true,
  );
}
