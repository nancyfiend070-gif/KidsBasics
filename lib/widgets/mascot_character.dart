import 'dart:math';

import 'package:flutter/material.dart';

enum MascotEmotion {
  happy,
  clapping,
  encouraging,
  celebrating,
  thinking,
}

/// Cute mascot character that reacts to user actions
class MascotCharacter extends StatefulWidget {
  final MascotEmotion emotion;
  final double size;
  final VoidCallback? onTap;

  const MascotCharacter({
    super.key,
    this.emotion = MascotEmotion.happy,
    this.size = 80,
    this.onTap,
  });

  @override
  State<MascotCharacter> createState() => _MascotCharacterState();
}

class _MascotCharacterState extends State<MascotCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(MascotCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.emotion != oldWidget.emotion) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final bounce = sin(_bounceAnimation.value * 2 * 3.14159) * 5;
          return Transform.translate(
            offset: Offset(0, bounce),
            // child: _buildEmoji(),
          );
        },
      ),
    );
  }

  Widget _buildEmoji() {
    final emoji = switch (widget.emotion) {
      MascotEmotion.happy => '😊',
      MascotEmotion.clapping => '👏',
      MascotEmotion.encouraging => '💪',
      MascotEmotion.celebrating => '🎉',
      MascotEmotion.thinking => '🤔',
    };

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      // child: Center(
      //   child: Text(
      //     emoji,
      //     style: TextStyle(fontSize: widget.size * 0.6),
      //   ),
      // ),
    );
  }
}
