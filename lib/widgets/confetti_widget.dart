import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart' as confetti_package;
import 'dart:math';

class SuccessConfetti extends StatefulWidget {
  final VoidCallback? onComplete;

  const SuccessConfetti({super.key, this.onComplete});

  @override
  State<SuccessConfetti> createState() => _SuccessConfettiState();
}

class _SuccessConfettiState extends State<SuccessConfetti> {
  late confetti_package.ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = confetti_package.ConfettiController(duration: const Duration(seconds: 3));
    _controller.play();
    Future.delayed(const Duration(seconds: 3), () {
      if (widget.onComplete != null) {
        widget.onComplete!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // More vibrant, kid-friendly colors
    final colors = const [
      Color(0xFFFF6B9D), // Bright pink
      Color(0xFF4ECDC4), // Turquoise
      Color(0xFFFFE66D), // Bright yellow
      Color(0xFF95E1D3), // Mint green
      Color(0xFFFF8C42), // Vibrant orange
      Color(0xFFA8E6CF), // Light green
      Color(0xFFFFB6C1), // Light pink
      Color(0xFF87CEEB), // Sky blue
      Color(0xFFFFD700), // Gold
      Color(0xFFDA70D6), // Orchid
      Color(0xFF00CED1), // Dark turquoise
      Color(0xFFFF1493), // Deep pink
    ];

    return IgnorePointer(
      child: Stack(
        children: [
          // Top center blast - main celebration (from top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.3,
            child: confetti_package.ConfettiWidget(
              confettiController: _controller,
              blastDirection: pi / 2,
              maxBlastForce: 8,
              minBlastForce: 3,
              emissionFrequency: 0.03,
              numberOfParticles: 60,
              gravity: 0.08,
              colors: colors,
              shouldLoop: false,
            ),
          ),
          // Left side blast
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.3,
            child: confetti_package.ConfettiWidget(
              confettiController: _controller,
              blastDirection: 0,
              maxBlastForce: 6,
              minBlastForce: 2,
              emissionFrequency: 0.04,
              numberOfParticles: 40,
              gravity: 0.1,
              colors: colors,
              shouldLoop: false,
            ),
          ),
          // Right side blast
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.3,
            child: confetti_package.ConfettiWidget(
              confettiController: _controller,
              blastDirection: pi,
              maxBlastForce: 6,
              minBlastForce: 2,
              emissionFrequency: 0.04,
              numberOfParticles: 40,
              gravity: 0.1,
              colors: colors,
              shouldLoop: false,
            ),
          ),
        ],
      ),
    );
  }
}
