import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Reusable Lottie wrapper: background (loop), character (loop), celebration (once).
class AppLottieView extends StatelessWidget {
  const AppLottieView({
    super.key,
    required this.asset,
    this.loop = true,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });

  /// Full-screen or card background motion (e.g. aurora blobs).
  const AppLottieView.background({
    Key? key,
    required String asset,
    BoxFit fit = BoxFit.cover,
  }) : this(
          key: key,
          asset: asset,
          loop: true,
          fit: fit,
          width: null,
          height: null,
          alignment: Alignment.center,
        );

  /// Looping character / mascot.
  const AppLottieView.character({
    Key? key,
    required String asset,
    double? width,
    double? height,
  }) : this(
          key: key,
          asset: asset,
          loop: true,
          fit: BoxFit.contain,
          width: width,
          height: height,
          alignment: Alignment.center,
        );

  /// One-shot celebration (confetti burst).
  const AppLottieView.celebration({
    Key? key,
    required String asset,
    double? width,
    double? height,
  }) : this(
          key: key,
          asset: asset,
          loop: false,
          fit: BoxFit.contain,
          width: width,
          height: height,
          alignment: Alignment.center,
        );

  final String asset;
  final bool loop;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Lottie.asset(
        asset,
        fit: fit,
        repeat: loop,
        alignment: alignment,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      ),
    );
  }
}
