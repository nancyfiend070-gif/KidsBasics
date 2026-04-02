import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../services/audio_service.dart';
import '../../monetization/ad_manager.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/glowing_container.dart';
import '../../constants/index.dart';
import '../../core/theme/app_text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    Colors.black,
                    const Color(0xFF0A0A1A),
                    const Color(0xFF001122),
                    const Color(0xFF001A33),
                  ]
                : [
                    const Color(0xFFF5F5F7),
                    Colors.white,
                    const Color(0xFFF0F0F5),
                  ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSizes.l),
            children: [
              GlassContainer(
                padding: const EdgeInsets.all(AppSizes.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.paintbrush,
                          color: isDark ? const Color(0xFF4A9EFF) : AppColors.primary,
                          size: 24,
                        ),
                        const SizedBox(width: AppSizes.m),
                        Text(
                          'Appearance',
                          style: AppTextStyles.titleSmall(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.l),
                    Obx(() => _buildThemeOption(
                          context,
                          'Light Mode',
                          ThemeMode.light,
                          themeController.themeMode.value,
                          CupertinoIcons.sun_max,
                          () => themeController.setThemeMode(ThemeMode.light),
                        )),
                    const SizedBox(height: AppSizes.m),
                    Obx(() => _buildThemeOption(
                          context,
                          'Dark Mode',
                          ThemeMode.dark,
                          themeController.themeMode.value,
                          CupertinoIcons.moon,
                          () => themeController.setThemeMode(ThemeMode.dark),
                        )),
                    const SizedBox(height: AppSizes.m),
                    Obx(() => _buildThemeOption(
                          context,
                          'System Default',
                          ThemeMode.system,
                          themeController.themeMode.value,
                          CupertinoIcons.device_desktop,
                          () => themeController.setThemeMode(ThemeMode.system),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.l),
              GlassContainer(
                padding: const EdgeInsets.all(AppSizes.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.speaker_2,
                          color: isDark ? const Color(0xFF4A9EFF) : AppColors.primary,
                          size: 24,
                        ),
                        const SizedBox(width: AppSizes.m),
                        Text(
                          'Sound check',
                          style: AppTextStyles.titleSmall(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.s),
                    Text(
                      'MP3/WAV effects: turn up Mac volume. Simulator: menu I/O → Audio Output → Mac Speakers.',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: AppSizes.m),
                    Text(
                      'Spoken words use Text-to-Speech (separate from MP3). Use Listen buttons on Learn/Quiz.',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: AppSizes.l),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () async {
                          final ok = await Get.find<AudioService>().verifyTapSound();
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ok
                                    ? 'Tap sound played (check volume)'
                                    : 'Tap sound failed — see Flutter console',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.touch_app),
                        label: const Text('Test tap sound'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.l),
              GlassContainer(
                padding: const EdgeInsets.all(AppSizes.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar_circle,
                          color: isDark ? const Color(0xFF4A9EFF) : AppColors.primary,
                          size: 24,
                        ),
                        const SizedBox(width: AppSizes.m),
                        Text(
                          'Monetization',
                          style: AppTextStyles.titleSmall(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.s),
                    Obx(() {
                      final manager = Get.find<AdManager>();
                      final removed = manager.adsRemoved.value;

                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: removed
                              ? null
                              : () async {
                                  manager.onUserAction(); // allow ads after first tap
                                  await manager.startRemoveAdsPurchase();
                                },
                          child: Text(
                            removed ? 'Ads removed' : 'Remove Ads ₹99',
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: AppSizes.m),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await Get.find<AdManager>().restorePurchases();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Restore purchases'),
                      ),
                    ),
                    const SizedBox(height: AppSizes.s),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => Get.toNamed(AppRoutes.adDemo),
                        icon: const Icon(Icons.slideshow),
                        label: const Text('Ad demo screen'),
                      ),
                    ),
                    const SizedBox(height: AppSizes.s),
                    Text(
                      'Purchases are stored on-device. Test ads and test store setup are required for dev.',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.l),
              GlassContainer(
                padding: const EdgeInsets.all(AppSizes.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.info,
                          color: isDark ? const Color(0xFF4A9EFF) : AppColors.primary,
                          size: 24,
                        ),
                        const SizedBox(width: AppSizes.m),
                        Text(
                          'About',
                          style: AppTextStyles.titleSmall(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.l),
                    _buildInfoRow(context, 'App Name', AppStrings.appName),
                    const SizedBox(height: AppSizes.m),
                    _buildInfoRow(context, 'Version', AppStrings.appVersion),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    ThemeMode mode,
    ThemeMode currentMode,
    IconData icon,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = mode == currentMode;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.m),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF4A9EFF).withOpacity(0.2) : AppColors.primary.withOpacity(0.1))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: Border.all(
            color: isSelected
                ? (isDark ? const Color(0xFF4A9EFF) : AppColors.primary)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.s),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? const Color(0xFF4A9EFF) : AppColors.primary)
                    : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white70 : Colors.black54),
                size: 20,
              ),
            ),
            const SizedBox(width: AppSizes.m),
            Expanded(
              child: Text(
                title,
                style: isSelected 
                    ? AppTextStyles.labelLarge(context)
                    : AppTextStyles.bodyMedium(context),
              ),
            ),
            if (isSelected)
              GlowingContainer(
                glowColor: isDark ? const Color(0xFF4A9EFF) : AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                child: Icon(
                  CupertinoIcons.checkmark_circle_fill,
                  color: isDark ? const Color(0xFF4A9EFF) : AppColors.primary,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.subtitleMedium(context),
        ),
        Text(
          value,
          style: AppTextStyles.bodyLarge(context).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
