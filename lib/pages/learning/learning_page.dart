import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_basics_learning/models/lesson_model.dart';
import 'package:kids_basics_learning/services/tts_service.dart';
import '../../models/category_model.dart';
import '../../constants/index.dart';
import '../../core/theme/app_text_styles.dart';
import '../../controllers/learning_controller.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/flying_emojis.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/floating_particles.dart';
import '../../widgets/bouncing_letter.dart';
import '../../widgets/mascot_character.dart';
import '../../widgets/progress_indicator_widget.dart';
import '../../widgets/star_reward.dart';
import '../../widgets/draggable_image.dart';
import '../../widgets/confetti_widget.dart';
import '../../widgets/ads/bottom_banner_ad.dart';
import '../../monetization/ad_manager.dart';

class LearningPage extends StatelessWidget {
  final CategoryModel category;

  const LearningPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + AppSizes.s,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.m, AppSizes.s, AppSizes.m, 0),
            child: GlassContainer(
              blur: 16,
              opacity: isDark ? 0.10 : 0.16,
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
                      'Learn ${category.title}',
                      style: AppTextStyles.titleSmall(context).copyWith(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              category.color.withOpacity(0.3),
              category.color.withOpacity(0.1),
              category.color.withOpacity(0.05),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating particles background
            FloatingParticles(
              color: category.color.withOpacity(0.15),
              particleCount: 15,
            ),
            GetX<LearningController>(
              tag: category.id,
              init: LearningController(category),
              autoRemove: true,
              builder: (controller) {
                final tts = Get.find<TtsService>();

                return SafeArea(
                  child: Column(
                    children: [
                      // Progress indicator
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSizes.m,
                          AppSizes.m,
                          AppSizes.m,
                          0,
                        ),
                        child: Obx(() => ProgressIndicatorWidget(
                          current: controller.currentIndex.value + 1,
                          total: controller.totalLessons,
                          color: category.color,
                        )),
                      ),
                      const SizedBox(height: 0),
                      Expanded(
                        child: Obx(() {
                          // Use AnimatedSwitcher for smooth transitions
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.3, 0),
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                )),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: _buildLessonContent(
                              context,
                              controller,
                              controller.currentLesson,
                              tts,
                              isDark,
                              key: ValueKey(controller.currentIndex.value),
                            ),
                          );
                        }),
                      ),
                      // Bottom navigation
                      _buildBottomNavigation(context, controller, isDark),
                    ],
                  ),
                );
              },
            ),
            // Star reward overlay
            Obx(() {
              final controller = Get.find<LearningController>(tag: category.id);
              if (controller.showStarReward.value) {
                return Positioned.fill(
                  child: Center(
                    child: StarReward(
                      color: category.color,
                      onComplete: () => controller.showStarReward.value = false,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonContent(
    BuildContext context,
    LearningController controller,
    LessonModel lesson,
    TtsService tts,
    bool isDark, {
    Key? key,
  }) {
    final isAlphabet = category.type == CategoryType.alphabet ||
        (category.type == CategoryType.quiz && controller.isAlphabetLesson);
    final isNumber = category.type == CategoryType.number;

    return SingleChildScrollView(
      key: key,
      padding: const EdgeInsets.all(AppSizes.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top spacing comes from progress row + SizedBox(22) above
          const SizedBox(height: 8),
          // Mascot character
          Obx(() => MascotCharacter(
            emotion: controller.mascotEmotion.value,
            size: 100,
            onTap: () => controller.onImageTap(),
          )),
          const SizedBox(height: AppSizes.xl),
          // Main content area
          Stack(
            alignment: Alignment.center,
            children: [
              // Glow effect when audio is playing
              Obx(() => tts.isPlaying.value
                  ? Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: category.color.withOpacity(0.5),
                            blurRadius: 40,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink()),
              // Main emoji/image
              if (lesson.isEmoji)
                DraggableImage(
                  emoji: lesson.image,
                  size: 250,
                  onTap: () {
                    controller.onImageTap();
                    _triggerFlyingEmojis(context, lesson.image);
                  },
                  onDragEnd: () {
                    controller.mascotEmotion.value = MascotEmotion.happy;
                  },
                )
              else if (isAlphabet || isNumber)
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: category.color.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: isAlphabet
                        ? BouncingLetter(
                            letter: lesson.title,
                            fontSize: 120,
                            color: category.color,
                            onTap: () => controller.onLetterTap(),
                          )
                        : BouncingLetter(
                            letter: lesson.title,
                            fontSize: 100,
                            color: category.color,
                            onTap: () => controller.onLetterTap(),
                          ),
                  ),
                )
              else
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: category.color.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      lesson.image.isNotEmpty ? lesson.image : lesson.title,
                      style: TextStyle(
                        fontSize: 100,
                        color: category.color,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSizes.xl),
          // Title and description
          Text(
            lesson.title,
            style: AppTextStyles.titleLarge(context).copyWith(
              color: category.color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          if (lesson.description != null && lesson.description!.isNotEmpty) ...[
            const SizedBox(height: AppSizes.s),
            Text(
              lesson.description!,
              style: AppTextStyles.subtitleLarge(context).copyWith(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: AppSizes.xl),
          // Audio button with enhanced styling
          GlassContainer(
            padding: const EdgeInsets.all(AppSizes.m),
            blur: 12,
            opacity: isDark ? 0.15 : 0.20,
            borderRadius: BorderRadius.circular(AppSizes.radiusXL),
            child: Obx(() => AnimatedButton(
              text: tts.isPlaying.value
                  ? '🔊 Playing...'
                  : '🔊 Listen & Learn',
              color: category.color,
              onTap: () async {
                _triggerFlyingEmojis(
                  context,
                  lesson.isEmoji ? lesson.image : '✨',
                );
                await controller.playAudio();
              },
            )),
          ),
          // Caption text
          Obx(() {
            if (tts.caption.value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSizes.m),
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.l,
                    vertical: AppSizes.m,
                  ),
                  blur: 8,
                  opacity: isDark ? 0.12 : 0.18,
                  borderRadius: BorderRadius.circular(AppSizes.radiusL),
                  child: Text(
                    tts.caption.value,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitleMedium(context).copyWith(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          const SizedBox(height: AppSizes.xl),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    LearningController controller,
    bool isDark,
  ) {
    return Container(
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSizes.radiusXL)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedButton(
                  text: '← Previous',
                  color: controller.currentIndex.value > 0
                      ? category.color
                      : AppColors.grey,
                  onTap: controller.currentIndex.value > 0
                      ? () async {
                          await controller.previousLesson();
                        }
                      : () {},
                ),
                Obx(() => Text(
                      '${controller.currentIndex.value + 1} / ${controller.totalLessons}',
                      style: AppTextStyles.titleSmall(context).copyWith(
                        color: isDark ? Colors.white : category.color,
                      ),
                    )),
                AnimatedButton(
                  text: controller.currentIndex.value < controller.totalLessons - 1
                      ? 'Next →'
                      : '🎉 Finish',
                  color: controller.currentIndex.value < controller.totalLessons - 1
                      ? category.color
                      : Colors.green,
                  onTap: controller.currentIndex.value < controller.totalLessons - 1
                      ? () async {
                          await controller.nextLesson();
                        }
                      : () {
                          controller.celebrateCompletion();
                          // Show completion confetti
                          SuccessConfetti(onComplete: () {});
                        },
                ),
              ],
            ),
            GetX<AdManager>(builder: (manager) {
              if (!manager.shouldShowBanner) return const SizedBox.shrink();
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
    );
  }

  void _triggerFlyingEmojis(BuildContext context, String emoji) {
    final emojis = [emoji, emoji, emoji];
    FlyingEmojis.show(context, emojis: emojis, count: 12);
  }
}
