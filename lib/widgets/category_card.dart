import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/category_model.dart';
import '../constants/app_sizes.dart';
import '../constants/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import 'glass_container.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        margin: const EdgeInsets.all(AppSizes.xs),
        padding: const EdgeInsets.all(AppSizes.m),
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        // Slight tint per category, still "glass"
        color: isDark ? category.color : Colors.white,
        opacity: isDark ? 0.12 : 0.18,
        blur: 14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                padding: (category.type == CategoryType.alphabet || category.type == CategoryType.number)
                    ? const EdgeInsets.all(AppSizes.m)
                    : const EdgeInsets.all(AppSizes.s),
                decoration: BoxDecoration(
                  color: category.color.withOpacity(isDark ? 0.22 : 0.14),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: category.color.withOpacity(isDark ? 0.25 : 0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    category.icon,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.s),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
                child: Text(
                  category.title,
                  style: AppTextStyles.categoryTitle(
                    context,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (category.isPremium) ...[
              const SizedBox(height: 2),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.warning, AppColors.warning.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.warning.withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.star_fill, size: 10, color: Colors.white),
                      SizedBox(width: 3),
                      Text(
                        'Premium',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
