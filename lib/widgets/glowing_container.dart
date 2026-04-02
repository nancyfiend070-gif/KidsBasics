import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class GlowingContainer extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlowingContainer({
    super.key,
    required this.child,
    required this.glowColor,
    this.glowRadius = 20.0,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  State<GlowingContainer> createState() => _GlowingContainerState();
}

class _GlowingContainerState extends State<GlowingContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // For light theme: use dark glow (black/grey)
    // For dark theme: use bright glow (current color)
    final effectiveGlowColor = isDark 
        ? widget.glowColor 
        : Colors.black.withOpacity(0.3);
    
    final glowIntensity = isDark ? 0.6 : 0.4;
    final glowSpread = isDark ? 5.0 : 3.0;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(AppSizes.radiusL),
            boxShadow: [
              BoxShadow(
                color: effectiveGlowColor.withOpacity(_animation.value * glowIntensity),
                blurRadius: widget.glowRadius * _animation.value,
                spreadRadius: glowSpread * _animation.value,
              ),
              BoxShadow(
                color: effectiveGlowColor.withOpacity(_animation.value * (glowIntensity * 0.5)),
                blurRadius: widget.glowRadius * 1.5 * _animation.value,
                spreadRadius: (glowSpread * 0.5) * _animation.value,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}
