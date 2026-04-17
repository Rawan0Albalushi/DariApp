import 'package:dari/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme() {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primaryAccent,
          brightness: Brightness.light,
          primary: AppColors.primaryAccent,
          secondary: AppColors.secondaryAccent,
          surface: AppColors.background,
        ).copyWith(
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.textPrimary,
        );

    final TextTheme textTheme = GoogleFonts.ibmPlexSansArabicTextTheme().copyWith(
      displayLarge: GoogleFonts.ibmPlexSansArabic(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displayMedium: GoogleFonts.ibmPlexSansArabic(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleLarge: GoogleFonts.ibmPlexSansArabic(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.ibmPlexSansArabic(
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.ibmPlexSansArabic(
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
    );

    const BorderRadius roundedCorners = BorderRadius.all(Radius.circular(14));

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.ibmPlexSansArabic(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.secondaryAccent,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: roundedCorners),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: GoogleFonts.ibmPlexSansArabic(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: GoogleFonts.ibmPlexSansArabic(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: roundedCorners,
          borderSide: BorderSide(
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: roundedCorners,
          borderSide: BorderSide(
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: roundedCorners,
          borderSide: BorderSide(color: AppColors.primaryAccent, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: roundedCorners,
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
