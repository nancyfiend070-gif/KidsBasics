import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/app_data.dart';
import '../../widgets/animated_category_card.dart';
import '../../widgets/floating_particles.dart';
import '../../widgets/glass_container.dart';
import '../../constants/index.dart';
import '../../constants/app_routes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/ads/bottom_banner_ad.dart';
import 'category_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter out Math Tables category
    final categories = AppData.getCategories()
        .where((category) => category.id != 'math')
        .toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Vibrant colorful gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        const Color(0xFF1A0033), // Deep purple
                        const Color(0xFF330066), // Rich purple
                        const Color(0xFF000033), // Deep blue
                        const Color(0xFF1A1A3D), // Dark blue-purple
                      ]
                    : [
                        const Color(0xFFFFE5F1), // Soft pink
                        const Color(0xFFE5F5FF), // Light blue
                        const Color(0xFFFFF5E5), // Warm cream
                        const Color(0xFFF0E5FF), // Lavender
                      ],
                stops: const [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),
          // Floating particles overlay
          FloatingParticles(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.purple.withOpacity(0.1),
            particleCount: 25,
            speed: 0.6,
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Enhanced header with vibrant colors
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(
                //     AppSizes.l,
                //     AppSizes.l,
                //     AppSizes.l,
                //     AppSizes.m,
                //   ),
                //   child: GlassContainer(
                //     padding: const EdgeInsets.all(AppSizes.l),
                //     blur: 20,
                //     opacity: isDark ? 0.15 : 0.25,
                //     borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             // ShaderMask(
                //             //   shaderCallback: (bounds) => LinearGradient(
                //             //     colors: isDark
                //             //         ? [
                //             //             Colors.purpleAccent,
                //             //             Colors.blueAccent,
                //             //             Colors.pinkAccent,
                //             //           ]
                //             //         : [
                //             //             const Color(0xFFFF6B9D),
                //             //             const Color(0xFF4ECDC4),
                //             //             const Color(0xFFFFE66D),
                //             //           ],
                //             //   ).createShader(bounds),
                //             //   child: Text(
                //             //     'Hello! 👋',
                //             //     style: AppTextStyles.titleLarge(context).copyWith(
                //             //       color: Colors.white,
                //             //       fontWeight: FontWeight.bold,
                //             //     ),
                //             //   ),
                //             // ),
                //             // const SizedBox(height: AppSizes.xs),
                //             // Text(
                //             //   'Let\'s Learn Together',
                //             //   style: AppTextStyles.subtitleLarge(context).copyWith(
                //             //     color: isDark ? Colors.white70 : Colors.black54,
                //             //     fontWeight: FontWeight.w600,
                //             //   ),
                //             // ),
                //           ],
                //         ),
                //         GestureDetector(
                //           onTap: () => Get.toNamed(AppRoutes.settings),
                //           child: GlassContainer(
                //             borderRadius: BorderRadius.circular(999),
                //             blur: 16,
                //             opacity: isDark ? 0.15 : 0.25,
                //             padding: const EdgeInsets.all(AppSizes.m),
                //             child: Icon(
                //               CupertinoIcons.settings,
                //               color: isDark ? Colors.white : Colors.black87,
                //               size: 22,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Category grid with animations
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(AppSizes.m),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: AppSizes.m,
                      mainAxisSpacing: AppSizes.m,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return AnimatedCategoryCard(
                        category: category,
                        index: index,
                        delay: Duration(milliseconds: index * 100),
                        onTap: () => Get.to(() => CategoryDetailPage(category: category)),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.s),
                const BottomBannerAd(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
