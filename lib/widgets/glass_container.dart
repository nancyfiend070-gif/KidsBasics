import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double blur;
  final double opacity;
  final bool withBorder;
  final bool withShadow;
  final BorderRadius? borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.blur = 10.0,
    this.opacity = 0.2,
    this.withBorder = true,
    this.withShadow = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // For light theme with no explicit color, keep glass mostly white (no grey cast)
    final bool hasCustomColor = color != null;
    final base = hasCustomColor
        ? color!
        : (isDark ? Colors.white : Colors.white);
    final containerColor = base.withOpacity(opacity);
    final radius = borderRadius ?? BorderRadius.circular(AppSizes.radiusL);
    final borderColor = isDark ? Colors.white.withOpacity(0.14) : Colors.white.withOpacity(0.65);
    
    // For dark theme with custom color, use transparent gradient instead of white/gray
    final List<Color> gradientColors;
    if (isDark && hasCustomColor) {
      // Use transparent to colorful gradient in dark theme
      gradientColors = [
        Colors.transparent,
        containerColor,
      ];
    } else {
      // Light theme or no custom color: use white highlight
      final highlightColor = isDark ? Colors.white.withOpacity(0.10) : Colors.white.withOpacity(0.85);
      gradientColors = [
        highlightColor,
        containerColor,
      ];
    }
    
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: (isDark ? Colors.black : Colors.black).withOpacity(isDark ? 0.35 : 0.10),
                  blurRadius: 18,
                  spreadRadius: 0,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
        border: withBorder
            ? Border.all(
                color: borderColor,
                width: 1.0,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
