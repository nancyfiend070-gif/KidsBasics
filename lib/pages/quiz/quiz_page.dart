import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_basics_learning/widgets/glass_container.dart';
import '../../models/category_model.dart';
import '../../constants/index.dart';
import '../../core/theme/app_text_styles.dart';
import '../../controllers/quiz_controller.dart';
import '../../services/tts_service.dart';
import '../../monetization/ad_manager.dart';
import '../../widgets/ads/bottom_banner_ad.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/confetti_widget.dart';

class QuizPage extends StatelessWidget {
  final CategoryModel category;

  const QuizPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    Get.put(QuizController(category));
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
                      '${category.title} Quiz',
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              category.color.withOpacity(0.2),
              category.color.withOpacity(0.05),
            ],
          ),
        ),
        child: Obx(() {
          final controller = Get.find<QuizController>();
          final adManager = Get.find<AdManager>();

          return Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSizes.l),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question ${controller.currentIndex.value + 1}/${controller.quizzes.length}',
                            style: AppTextStyles.titleSmall(
                              context,
                            ).copyWith(color: category.color),
                          ),
                          Text(
                            'Score: ${controller.score.value}',
                            style: AppTextStyles.titleSmall(
                              context,
                            ).copyWith(color: category.color),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.l,
                        ),
                        child: Column(
                          children: [
                            GlassContainer(
                              width: double.infinity,
                              padding: const EdgeInsets.all(AppSizes.xl),
                              margin: const EdgeInsets.only(
                                bottom: AppSizes.xl,
                              ),
                              blur: 16,
                              opacity: isDark ? 0.15 : 0.20,
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusXL,
                              ),
                              child: Column(
                                children: [
                                  if (controller.currentQuiz.image != null &&
                                      controller
                                          .currentQuiz
                                          .image!
                                          .isNotEmpty &&
                                      !controller.currentQuiz.image!.startsWith(
                                        'assets/',
                                      ))
                                    Text(
                                      controller.currentQuiz.image!,
                                      style: const TextStyle(fontSize: 60),
                                    ),
                                  const SizedBox(height: AppSizes.m),
                                  Text(
                                    controller.currentQuiz.question,
                                    style: AppTextStyles.quizQuestion(
                                      context,
                                      color: category.color,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: AppSizes.m),
                                  Obx(() {
                                    final tts = Get.find<TtsService>();
                                    return AnimatedButton(
                                      text: tts.isPlaying.value ? '🔊 Playing...' : '🔊 Listen',
                                      color: category.color,
                                      onTap: () => _playQuestionAudio(controller),
                                    );
                                  }),
                                  Obx(() {
                                    final tts = Get.find<TtsService>();
                                    if (tts.caption.value.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: AppSizes.s),
                                        child: Text(
                                          tts.caption.value,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.subtitleMedium(context).copyWith(
                                            color: Theme.of(context).brightness == Brightness.dark 
                                                ? Colors.white70 
                                                : Colors.black54,
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                ],
                              ),
                            ),
                            ...controller.currentQuiz.options
                                .asMap()
                                .entries
                                .map((entry) {
                                  final index = entry.key;
                                  final option = entry.value;
                                  final isSelected =
                                      controller.selectedAnswer.value == index;

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppSizes.m,
                                    ),
                                    child: InkWell(
                                      onTap: () =>
                                          controller.selectAnswer(index),
                                      child: isSelected
                                          ? Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(
                                                AppSizes.l,
                                              ),
                                              decoration: BoxDecoration(
                                                color: category.color,
                                                borderRadius: BorderRadius.circular(
                                                  AppSizes.radiusL,
                                                ),
                                                border: Border.all(
                                                  color: category.color,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Text(
                                                option,
                                                style: AppTextStyles.quizOption(
                                                  context,
                                                  color: Colors.white,
                                                  isSelected: isSelected,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : GlassContainer(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(
                                                AppSizes.l,
                                              ),
                                              blur: 12,
                                              opacity: isDark ? 0.12 : 0.18,
                                              borderRadius: BorderRadius.circular(
                                                AppSizes.radiusL,
                                              ),
                                              child: Text(
                                                option,
                                                style: AppTextStyles.quizOption(
                                                  context,
                                                  color: category.color,
                                                  isSelected: isSelected,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                    ),
                                  );
                                }),
                            // Extra padding at bottom for button space
                            const SizedBox(height: 160),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // One combined bottom area:
              // - banner (optional)
              // - 12px gap
              // - check answer button
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppSizes.l),
                    blur: Theme.of(context).brightness == Brightness.dark ? 16 : 0,
                    opacity: Theme.of(context).brightness == Brightness.dark ? 0.15 : 0.0,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSizes.radiusXL),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedButton(
                          text: 'Check Answer',
                          color: controller.selectedAnswer.value != -1
                              ? category.color
                              : AppColors.grey,
                          onTap: controller.selectedAnswer.value != -1
                              ? () => _handleAnswer(context, controller)
                              : () {},
                        ),
                        if (adManager.showBanner.value) ...[
                          const SizedBox(height: 12),
                          const BottomBannerAd(),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              // Confetti overlay - doesn't take layout space
              if (controller.showConfetti.value)
                const Positioned.fill(child: SuccessConfetti()),
            ],
          );
        }),
      ),
    );
  }

  Future<void> _playQuestionAudio(QuizController controller) async {
    final tts = Get.find<TtsService>();

    if (tts.isPlaying.value) {
      await tts.stop();
    } else {
      // Check if it's an alphabet question
      if (controller.isAlphabetQuestion && controller.alphabetLetter != null) {
        await tts.speakLetter(controller.alphabetLetter!);
      } else {
        // For other questions, just speak the question text
        await tts.speakWord(controller.currentQuiz.question);
      }
    }
  }

  void _handleAnswer(BuildContext context, QuizController controller) async {
    await controller.checkAnswer();

    if (controller.isLastQuestion) {
      Future.delayed(
        const Duration(seconds: 1),
        () => _showResults(context, controller),
      );
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        controller.nextQuestion();
      });
    }
  }

  void _showResults(BuildContext context, QuizController controller) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) => Stack(
        children: [
          AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [category.color, category.color.withOpacity(0.7)],
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
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🎊', style: TextStyle(fontSize: 80)),
                    const SizedBox(height: 20),
                    Text(
                      'Quiz Complete!',
                      style: AppTextStyles.titleLarge(
                        context,
                      ).copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'You got ${controller.score.value} out of ${controller.quizzes.length} correct!',
                      style: AppTextStyles.bodyLarge(
                        context,
                      ).copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: category.color,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SuccessConfetti(),
        ],
      ),
    );
  }
}
