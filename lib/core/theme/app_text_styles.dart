import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Title Styles - Bold and Playful (Fredoka)
  static TextStyle titleLarge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.fredoka(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: isDark ? Colors.white : Colors.black87,
      letterSpacing: -0.5,
      height: 1.2,
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.fredoka(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : Colors.black87,
      letterSpacing: -0.3,
    );
  }

  static TextStyle titleSmall(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.fredoka(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : Colors.black87,
    );
  }

  // Subtitle Styles - Friendly (Nunito)
  static TextStyle subtitleLarge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white70 : Colors.black54,
      letterSpacing: 0.2,
    );
  }

  static TextStyle subtitleMedium(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: isDark ? Colors.white70 : Colors.black54,
    );
  }

  static TextStyle subtitleSmall(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: isDark ? Colors.white60 : Colors.black45,
    );
  }

  // Body Styles - Readable (Nunito)
  static TextStyle bodyLarge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: isDark ? Colors.white : Colors.black87,
      height: 1.5,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: isDark ? Colors.white : Colors.black87,
      height: 1.4,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: isDark ? Colors.white60 : Colors.black54,
    );
  }

  // Button Styles - Bold (Comic Neue)
  static TextStyle buttonLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.comicNeue(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: color ?? (isDark ? Colors.white : Colors.white),
      letterSpacing: 0.5,
    );
  }

  static TextStyle buttonMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.comicNeue(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color ?? (isDark ? Colors.white : Colors.white),
    );
  }

  // Category Card Title - Playful (Fredoka)
  static TextStyle categoryTitle(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.fredoka(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color ?? (isDark ? Colors.white : Colors.black87),
      letterSpacing: 0.3,
    );
  }

  // Learning Page - Large Display (Comic Neue)
  static TextStyle learningDisplay(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.comicNeue(
      fontSize: 120,
      fontWeight: FontWeight.w700,
      color: color ?? (isDark ? Colors.white : Colors.black87),
      letterSpacing: -2,
    );
  }

  // Quiz Question - Bold (Fredoka)
  static TextStyle quizQuestion(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.fredoka(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color ?? (isDark ? Colors.white : Colors.black87),
      letterSpacing: 0.2,
      height: 1.3,
    );
  }

  // Quiz Option - Friendly (Nunito)
  static TextStyle quizOption(BuildContext context, {Color? color, bool isSelected = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
      color: color ?? (isDark ? Colors.white : Colors.black87),
      letterSpacing: 0.3,
    );
  }

  // Label Styles - Medium Weight (Nunito)
  static TextStyle labelLarge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : Colors.black87,
    );
  }

  static TextStyle labelMedium(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white70 : Colors.black54,
    );
  }

  static TextStyle labelSmall(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.nunito(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: isDark ? Colors.white60 : Colors.black45,
    );
  }
}
