import 'dart:math';
import 'package:flutter/material.dart';

class FlyingEmojis {
  FlyingEmojis._();

  /// Shows a "like" style animation - emojis flying upward from a point
  static void show(
    BuildContext context, {
    required List<String> emojis,
    int count = 8,
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    if (emojis.isEmpty) return;

    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _FlyingEmojisOverlay(
        emojis: emojis,
        count: count,
        duration: duration,
        onDone: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _FlyingEmojisOverlay extends StatefulWidget {
  final List<String> emojis;
  final int count;
  final Duration duration;
  final VoidCallback onDone;

  const _FlyingEmojisOverlay({
    required this.emojis,
    required this.count,
    required this.duration,
    required this.onDone,
  });

  @override
  State<_FlyingEmojisOverlay> createState() => _FlyingEmojisOverlayState();
}

class _FlyingEmojisOverlayState extends State<_FlyingEmojisOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _rnd = Random();
  late final List<_EmojiData> _emojiData;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDone();
      }
    });

    // Pre-generate random data for each emoji
    _emojiData = List.generate(widget.count, (i) {
      return _EmojiData(
        emoji: widget.emojis[i % widget.emojis.length],
        offsetX: (_rnd.nextDouble() - 0.5) * 100, // Spread horizontally
        speed: 0.5 + _rnd.nextDouble() * 0.5, // Random speed
        scale: 0.8 + _rnd.nextDouble() * 0.4, // Random size
        rotation: (_rnd.nextDouble() - 0.5) * 0.5, // Random rotation
        delay: i * 0.05, // Stagger delay
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final startX = size.width / 2;
    final startY = size.height * 0.6; // Start from button area

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: size,
            painter: _FlyingEmojisPainter(
              emojiData: _emojiData,
              progress: _controller.value,
              startX: startX,
              startY: startY,
            ),
          );
        },
      ),
    );
  }
}

class _EmojiData {
  final String emoji;
  final double offsetX;
  final double speed;
  final double scale;
  final double rotation;
  final double delay;

  _EmojiData({
    required this.emoji,
    required this.offsetX,
    required this.speed,
    required this.scale,
    required this.rotation,
    required this.delay,
  });
}

class _FlyingEmojisPainter extends CustomPainter {
  final List<_EmojiData> emojiData;
  final double progress;
  final double startX;
  final double startY;

  _FlyingEmojisPainter({
    required this.emojiData,
    required this.progress,
    required this.startX,
    required this.startY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (final data in emojiData) {
      final adjustedProgress = ((progress - data.delay) / (1 - data.delay)).clamp(0.0, 1.0);
      if (adjustedProgress <= 0) continue;

      final curve = Curves.easeOut.transform(adjustedProgress);
      
      // Calculate position - fly upward with horizontal spread
      final x = startX + data.offsetX * curve;
      final y = startY - (size.height * 0.4 * curve * data.speed);
      
      // Calculate opacity and scale
      final opacity = (1 - adjustedProgress).clamp(0.0, 1.0);
      final currentScale = 0.5 + (data.scale * adjustedProgress);
      final rotation = data.rotation * adjustedProgress;

      // Draw emoji
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.scale(currentScale);

      textPainter.text = TextSpan(
        text: data.emoji,
        style: const TextStyle(
          fontSize: 32,
          height: 1.0,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_FlyingEmojisPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

