import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/category_model.dart';
import '../models/lesson_model.dart';
import '../data/app_data.dart';
import '../services/tts_service.dart';
import '../services/audio_service.dart';
import '../monetization/ad_manager.dart';

class TracingController extends GetxController {
  final CategoryModel category;
  
  TracingController(this.category);

  final RxInt currentIndex = 0.obs;
  final RxList<LessonModel> lessons = <LessonModel>[].obs;
  final RxList<Offset> points = <Offset>[].obs;
  final RxBool showSuccess = false.obs;
  final RxBool canGoNext = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLessons();
  }

  void _loadLessons() {
    switch (category.type) {
      case CategoryType.alphabet:
        lessons.value = AppData.getAlphabetLessons();
        break;
      case CategoryType.number:
        lessons.value = AppData.getNumberLessons();
        break;
      case CategoryType.shape:
        lessons.value = AppData.getShapeLessons();
        break;
      default:
        lessons.value = [];
    }
  }

  void addPoint(Offset point) {
    points.add(point);
  }

  Future<void> addEndPoint() async {
    points.add(const Offset(-1, -1));
    // Simple length check so tiny taps don't count
    if (_currentStrokeLength() < 40 || lessons.isEmpty) return;

    // Mark this step as completed; user can press Next
    canGoNext.value = true;
  }

  void clearPoints() {
    points.clear();
    // Stay on the same item, just retry this letter/shape/number
    showSuccess.value = false;
    canGoNext.value = false;
  }

  Future<void> goNext() async {
    if (!canGoNext.value || lessons.isEmpty) return;

    if (currentIndex.value < lessons.length - 1) {
      currentIndex.value++;
      points.clear();
      canGoNext.value = false;
    } else {
      // Last item completed – show success once
      await showSuccessDialog();
      canGoNext.value = false;
    }
  }

  Future<void> showSuccessDialog() async {
    if (Get.isRegistered<AudioService>()) {
      await Get.find<AudioService>().playRewardCelebration();
    }
    final tts = Get.find<TtsService>();
    await tts.speakWord('Excellent! You traced it perfectly!');
    if (Get.isRegistered<AdManager>()) {
      Get.find<AdManager>().onActivityCompleted(major: true);
    }
    showSuccess.value = true;
    Future.delayed(const Duration(seconds: 3), () => showSuccess.value = false);
  }

  void hideSuccess() {
    showSuccess.value = false;
  }

  int _currentStrokeLength() {
    int len = 0;
    for (int i = points.length - 2; i >= 0; i--) {
      if (points[i] == const Offset(-1, -1)) break;
      len++;
    }
    return len;
  }
}
