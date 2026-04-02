import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
    final buttonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL, vertical: AppSizes.paddingM),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusM)),
      minimumSize: const Size(double.infinity, AppSizes.buttonHeightM),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: Colors.white,
        background: const Color(0xFFF5F5F7),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onBackground: Colors.black87,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttonStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.1)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: AppSizes.paddingS),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusS)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(borderSide: const BorderSide(color: AppColors.primary, width: 2)),
        errorBorder: baseBorder.copyWith(borderSide: const BorderSide(color: AppColors.error)),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: AppSizes.paddingM),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusL)),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.fredoka(fontSize: 57, fontWeight: FontWeight.w700, color: Colors.black87),
        displayMedium: GoogleFonts.fredoka(fontSize: 45, fontWeight: FontWeight.w700, color: Colors.black87),
        displaySmall: GoogleFonts.fredoka(fontSize: 36, fontWeight: FontWeight.w600, color: Colors.black87),
        headlineLarge: GoogleFonts.fredoka(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black87),
        headlineMedium: GoogleFonts.fredoka(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black87),
        headlineSmall: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
        titleLarge: GoogleFonts.fredoka(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
        titleMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
        titleSmall: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        bodyLarge: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
        bodyMedium: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
        bodySmall: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
        labelLarge: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        labelMedium: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
        labelSmall: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black45),
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      borderSide: const BorderSide(color: AppColors.primaryLight),
    );
    final buttonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL, vertical: AppSizes.paddingM),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusM)),
      minimumSize: const Size(double.infinity, AppSizes.buttonHeightM),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: Color(0xFF1A1028),
        background: Color(0xFF0E0718),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF0E0718),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF1A1028),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttonStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.all(const Color(0xFF4A9EFF).withOpacity(0.2)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: AppSizes.paddingS),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusS)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1A1028),
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(borderSide: const BorderSide(color: AppColors.primaryLight, width: 2)),
        errorBorder: baseBorder.copyWith(borderSide: const BorderSide(color: AppColors.error)),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: AppSizes.paddingM),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1A1028),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusL)),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.fredoka(fontSize: 57, fontWeight: FontWeight.w700, color: Colors.white),
        displayMedium: GoogleFonts.fredoka(fontSize: 45, fontWeight: FontWeight.w700, color: Colors.white),
        displaySmall: GoogleFonts.fredoka(fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white),
        headlineLarge: GoogleFonts.fredoka(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
        headlineMedium: GoogleFonts.fredoka(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
        headlineSmall: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        titleLarge: GoogleFonts.fredoka(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        titleMedium: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        titleSmall: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        bodyMedium: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        bodySmall: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white70),
        labelLarge: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        labelMedium: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70),
        labelSmall: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white60),
      ),
    );
  }
}
