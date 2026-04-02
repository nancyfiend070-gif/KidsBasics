import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../constants/index.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/floating_particles.dart';
import '../../widgets/ads/bottom_banner_ad.dart';
import '../learning/learning_page.dart';
import '../quiz/quiz_page.dart';
import '../tracing/tracing_page.dart';

class CategoryDetailPage extends StatelessWidget {
  final CategoryModel category;

  const CategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + AppSizes.s,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.m,
              AppSizes.s,
              AppSizes.m,
              0,
            ),
            child: GlassContainer(
              blur: 16,
              opacity: isDark ? 0.10 : 0.18,
              borderRadius: BorderRadius.circular(999),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.l,
                vertical: AppSizes.s,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.chevron_left),
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  const SizedBox(width: AppSizes.s),
                  Expanded(
                    child: Text(
                      category.title,
                      style: AppTextStyles.titleSmall(
                        context,
                      ).copyWith(color: isDark ? Colors.white : Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Vibrant gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  category.color.withOpacity(0.4),
                  category.color.withOpacity(0.2),
                  category.color.withOpacity(0.1),
                  category.color.withOpacity(0.05),
                ],
                stops: const [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),
          // Floating particles
          FloatingParticles(
            color: category.color.withOpacity(0.15),
            particleCount: 20,
            speed: 0.5,
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSizes.l),
                  child: GlassContainer(
                    blur: 20,
                    opacity: isDark ? 0.18 : 0.25,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                    padding: const EdgeInsets.all(AppSizes.xl),
                    color: category.color,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSizes.l),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                category.color.withOpacity(0.3),
                                category.color.withOpacity(0.2),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: category.color.withOpacity(0.5),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            category.icon,
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                        const SizedBox(height: AppSizes.m),
                        Text(
                          category.title,
                          style: AppTextStyles.titleLarge(context).copyWith(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: category.color.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.s),
                        Text(
                          category.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subtitleLarge(context).copyWith(
                            color: isDark ? Colors.white70 : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.l),
                    children: [
                      _buildActionCard(
                        context,
                        title: 'Learn',
                        icon: Icons.school,
                        description:
                            'Learn ${category.title.toLowerCase()} with fun',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LearningPage(category: category),
                          ),
                        ),
                      ),
                      if (category.type == CategoryType.alphabet ||
                          category.type == CategoryType.shape ||
                          category.type == CategoryType.number) ...[
                        const SizedBox(height: AppSizes.m),
                        _buildActionCard(
                          context,
                          title: 'Trace',
                          icon: Icons.edit,
                          description: category.type == CategoryType.alphabet
                              ? 'Trace A to Z step by step'
                              : category.type == CategoryType.number
                              ? 'Trace 1 to 10'
                              : 'Trace fun shapes',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TracingPage(category: category),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSizes.m),
                      _buildActionCard(
                        context,
                        title: 'Quiz',
                        icon: Icons.quiz,
                        description: 'Test your knowledge',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizPage(category: category),
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.m),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  category.color.withOpacity(0.2),
                  category.color.withOpacity(0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: category.color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: GlassContainer(
              blur: 16,
              opacity: isDark ? 0.15 : 0.22,
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
              padding: const EdgeInsets.all(AppSizes.l),
              color: category.color,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.m),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          category.color.withOpacity(0.4),
                          category.color.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      boxShadow: [
                        BoxShadow(
                          color: category.color.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: isDark ? Colors.white : Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: AppSizes.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.titleSmall(context).copyWith(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSizes.xs),
                        Text(
                          description,
                          style: AppTextStyles.subtitleMedium(context).copyWith(
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: isDark ? Colors.white70 : category.color,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
