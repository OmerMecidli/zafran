import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF3E5219);
  static const Color secondaryColor = Color(0xFF9F402D);
  static const Color backgroundColor = Color(0xFFFFF8F5);
  static const Color surfaceContainer = Color(0xFFF5ECE7);
  static const Color onSurface = Color(0xFF1E1B18);
  static const Color onSurfaceVariant = Color(0xFF45483C);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
      ),
      useMaterial3: true,

      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          color: onSurface,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          color: onSurface,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),

        bodyLarge: GoogleFonts.inter(
          color: onSurface,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.inter(
          color: onSurface,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

