import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_basics_learning/widgets/floating_particles.dart';
import '../../models/category_model.dart';
import '../../constants/index.dart';
import '../../controllers/tracing_controller.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/confetti_widget.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/ads/bottom_banner_ad.dart';
import '../../monetization/ad_manager.dart';

class TracingPage extends StatelessWidget {
  final CategoryModel category;

  const TracingPage({super.key, required this.category});

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
                    icon: const Icon(Icons.chevron_left),
                    color: isDark ? Colors.white : Colors.black87,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: AppSizes.s),
                  Expanded(
                    child: Text(
                      'Trace ${category.title}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    color: isDark ? Colors.white70 : Colors.black54,
                    onPressed: () => Get.find<TracingController>(
                      tag: category.id,
                    ).clearPoints(),
                    tooltip: 'Clear',
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
            particleCount: 15,
            speed: 0.4,
          ),
          // Main content
          GetX<TracingController>(
            tag: category.id,
            init: TracingController(category),
            autoRemove: true,
            builder: (controller) {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSizes.l),
                      child: Text(
                        controller.lessons.isNotEmpty
                            ? 'Trace ${controller.lessons[controller.currentIndex.value].title}'
                            : 'Trace',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: category.color,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusXL,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: category.color.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: controller.lessons.isEmpty
                                    ? const SizedBox.shrink()
                                    : () {
                                        final lesson =
                                            controller.lessons[controller
                                                .currentIndex
                                                .value];
                                        // For shapes, show the shape emoji; for others, show the title/letter/number
                                        final display =
                                            category.type ==
                                                    CategoryType.shape &&
                                                lesson.isEmoji
                                            ? lesson.image
                                            : lesson.title;
                                        return Text(
                                          display,
                                          style: TextStyle(
                                            fontSize: 150,
                                            fontWeight: FontWeight.bold,
                                            color: category.color.withOpacity(
                                              0.2,
                                            ),
                                          ),
                                        );
                                      }(),
                              ),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onPanUpdate: (details) {
                                      final local = details.localPosition;
                                      if (local.dx >= 0 &&
                                          local.dx <= constraints.maxWidth &&
                                          local.dy >= 0 &&
                                          local.dy <= constraints.maxHeight) {
                                        controller.addPoint(local);
                                      }
                                    },
                                    onPanEnd: (_) => controller.addEndPoint(),
                                    child: Obx(
                                      () => CustomPaint(
                                        size: Size(
                                          constraints.maxWidth,
                                          constraints.maxHeight,
                                        ),
                                        painter: TracingPainter(
                                          points: controller.points.toList(),
                                          color: category.color,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppSizes.l),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isDark
                              ? [
                                  Colors.transparent,
                                  category.color.withOpacity(0.1),
                                ]
                              : [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.0),
                                ],
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppSizes.radiusXL),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Obx(() {
                                final canNext = controller.canGoNext.value;
                                final isLast =
                                    controller.lessons.isEmpty ||
                                    controller.currentIndex.value >=
                                        controller.lessons.length - 1;
                                return AnimatedButton(
                                  text: isLast ? '🎉 Finish' : 'Next →',
                                  color: canNext ? category.color : AppColors.grey,
                                  onTap: canNext
                                      ? () => controller.goNext()
                                      : () {},
                                );
                              }),
                            ),
                            GetX<AdManager>(builder: (manager) {
                              if (!manager.shouldShowBanner) {
                                return const SizedBox.shrink();
                              }
                              return const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 12),
                                  BottomBannerAd(),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    controller.showSuccess.value
                        ? Stack(
                            children: [
                              AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Container(
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        category.color,
                                        category.color.withOpacity(0.7),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: category.color.withOpacity(0.5),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '🎉',
                                        style: TextStyle(fontSize: 80),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Excellent!',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'You traced it perfectly!',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SuccessConfetti(),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TracingPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;

  TracingPainter({required this.points, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != const Offset(-1, -1) &&
          points[i + 1] != const Offset(-1, -1)) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(TracingPainter oldDelegate) =>
      oldDelegate.points != points;
}
