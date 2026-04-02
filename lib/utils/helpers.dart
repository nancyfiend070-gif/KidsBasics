import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class Helpers {
  Helpers._();

  static void showSnackBar(BuildContext context, String message, {Color? backgroundColor, Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor, duration: duration ?? const Duration(seconds: 3), behavior: SnackBarBehavior.floating),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) => showSnackBar(context, message, backgroundColor: AppColors.success);
  static void showErrorSnackBar(BuildContext context, String message) => showSnackBar(context, message, backgroundColor: AppColors.error);

  static String formatDate(DateTime date) => '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 600;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;

  static double getResponsiveWidth(BuildContext context, {double mobile = 1.0, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    return isDesktop(context) && desktop != null ? width * desktop : isTablet(context) && tablet != null ? width * tablet : width * mobile;
  }
}
