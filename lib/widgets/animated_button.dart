import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_sizes.dart';
import '../monetization/ad_manager.dart';
import '../services/audio_service.dart';
import '../core/theme/app_text_styles.dart';
import 'glass_container.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final IconData? icon;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.icon,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        if (Get.isRegistered<AudioService>()) {
          Get.find<AudioService>().playTap();
        }
        if (Get.isRegistered<AdManager>()) {
          Get.find<AdManager>().onUserAction();
        }
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.l, vertical: AppSizes.m),
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          blur: 14,
          color: widget.color ?? Theme.of(context).primaryColor,
          opacity: Theme.of(context).brightness == Brightness.dark ? 0.25 : 0.20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white),
                const SizedBox(width: AppSizes.s),
              ],
              Text(
                widget.text,
                style: AppTextStyles.buttonLarge(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
