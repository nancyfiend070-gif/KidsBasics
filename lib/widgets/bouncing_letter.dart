import 'dart:math';

import 'package:flutter/material.dart';

/// Bouncing letter widget with scale and bounce animations
class BouncingLetter extends StatefulWidget {
  final String letter;
  final double fontSize;
  final Color? color;
  final VoidCallback? onTap;
  final bool autoAnimate;

  const BouncingLetter({
    super.key,
    required this.letter,
    this.fontSize = 120,
    this.color,
    this.onTap,
    this.autoAnimate = true,
  });

  @override
  State<BouncingLetter> createState() => _BouncingLetterState();
}

class _BouncingLetterState extends State<BouncingLetter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.autoAnimate) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(BouncingLetter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.letter != oldWidget.letter && widget.autoAnimate) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.reset();
    _controller.forward();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final bounceOffset = sin(_bounceAnimation.value * 2 * 3.14159) * 10;
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.translate(
              offset: Offset(0, bounceOffset * (1 - _scaleAnimation.value)),
              child: Text(
                widget.letter,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                  shadows: [
                    Shadow(
                      color: widget.color?.withOpacity(0.3) ?? Colors.black26,
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
