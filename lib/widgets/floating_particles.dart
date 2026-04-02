import 'dart:math';
import 'package:flutter/material.dart';

/// Floating particles/shapes background animation for kids' screens
class FloatingParticles extends StatefulWidget {
  final Color? color;
  final int particleCount;
  final double speed;

  const FloatingParticles({
    super.key,
    this.color,
    this.particleCount = 20,
    this.speed = 0.5,
  });

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Initialize particles
    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 20 + _random.nextDouble() * 40,
        speed: 0.3 + _random.nextDouble() * widget.speed,
        shape: _random.nextInt(3), // 0: circle, 1: star, 2: heart
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = widget.color ??
        (isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05));

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _FloatingParticlesPainter(
              particles: _particles,
              progress: _controller.value,
              color: color,
            ),
            size: MediaQuery.sizeOf(context),
          );
        },
      ),
    );
  }
}

class _Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final int shape;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.shape,
  });
}

class _FloatingParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;

  _FloatingParticlesPainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      // Update position with floating motion
      final offsetY = (progress * particle.speed * 100) % (size.height + 200);
      final offsetX = sin(progress * 2 * pi + particle.x * 10) * 30;

      final x = particle.x * size.width + offsetX;
      final y = (particle.y * size.height - offsetY) % (size.height + 200);

      canvas.save();
      canvas.translate(x, y);

      // Draw different shapes
      switch (particle.shape) {
        case 0: // Circle
          canvas.drawCircle(
            Offset.zero,
            particle.size / 2,
            paint,
          );
          break;
        case 1: // Star
          _drawStar(canvas, particle.size, paint);
          break;
        case 2: // Heart
          _drawHeart(canvas, particle.size, paint);
          break;
      }

      canvas.restore();
    }
  }

  void _drawStar(Canvas canvas, double size, Paint paint) {
    final path = Path();
    final center = Offset.zero;
    final outerRadius = size / 2;
    final innerRadius = outerRadius * 0.4;
    final spikes = 5;

    for (int i = 0; i < spikes * 2; i++) {
      final angle = (i * pi) / spikes;
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = center.dx + cos(angle - pi / 2) * radius;
      final y = center.dy + sin(angle - pi / 2) * radius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawHeart(Canvas canvas, double size, Paint paint) {
    final path = Path();
    final center = Offset.zero;
    final scale = size / 20;

    path.moveTo(center.dx, center.dy + 5 * scale);
    path.cubicTo(
      center.dx - 5 * scale,
      center.dy,
      center.dx - 10 * scale,
      center.dy - 5 * scale,
      center.dx,
      center.dy - 10 * scale,
    );
    path.cubicTo(
      center.dx + 10 * scale,
      center.dy - 5 * scale,
      center.dx + 5 * scale,
      center.dy,
      center.dx,
      center.dy + 5 * scale,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_FloatingParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
