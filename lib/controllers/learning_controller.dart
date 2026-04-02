import 'package:get/get.dart';
import '../models/category_model.dart';
import '../models/lesson_model.dart';
import '../data/app_data.dart';
import '../services/audio_service.dart';
import '../services/tts_service.dart';
import '../monetization/ad_manager.dart';
import '../widgets/mascot_character.dart';

class LearningController extends GetxController {
  final CategoryModel category;
  
  LearningController(this.category);

  final RxInt currentIndex = 0.obs;
  final RxList<LessonModel> lessons = <LessonModel>[].obs;
  final Rx<MascotEmotion> mascotEmotion = MascotEmotion.happy.obs;
  final RxBool showStarReward = false.obs;
  final RxInt completedLessons = 0.obs;
  final RxBool isAnimating = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLessons();
    updateCaption();
  }

  int get totalLessons => lessons.length;
  double get progress => totalLessons > 0 ? completedLessons.value / totalLessons : 0.0;

  void updateCaption() {
    if (lessons.isEmpty) return;
    final audio = Get.find<TtsService>();
    final lesson = currentLesson;

    // Check if it's an alphabet lesson (either alphabet category or alphabet in mixed mode)
    if (category.type == CategoryType.alphabet || 
        (category.type == CategoryType.quiz && isAlphabetLesson)) {
      // Show "A for Apple" immediately on next/prev (no need to press Listen)
      final l = lesson.title.trim().toUpperCase();
      final words = <String, String>{
        'A': 'Apple',
        'B': 'Bear',
        'C': 'Cat',
        'D': 'Dog',
        'E': 'Elephant',
        'F': 'Frog',
        'G': 'Giraffe',
        'H': 'Horse',
        'I': 'Iguana',
        'J': 'Juice',
        'K': 'Kangaroo',
        'L': 'Llama',
        'M': 'Monkey',
        'N': 'Nest',
        'O': 'Orange',
        'P': 'Penguin',
        'Q': 'Queen',
        'R': 'Rabbit',
        'S': 'Snake',
        'T': 'Tiger',
        'U': 'Unicorn',
        'V': 'Violin',
        'W': 'Whale',
        'X': 'X-ray',
        'Y': 'Yacht',
        'Z': 'Zebra',
      };
      audio.caption.value = '$l for ${words[l] ?? l}';
    } else if (category.type == CategoryType.number) {
      audio.caption.value = lesson.title; // "1", "2", ...
    } else {
      audio.caption.value = lesson.title;
    }
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
      case CategoryType.color:
        lessons.value = AppData.getColorLessons();
        break;
      case CategoryType.animal:
        lessons.value = AppData.getAnimalLessons();
        break;
      case CategoryType.fruit:
        lessons.value = AppData.getFruitLessons();
        break;
      case CategoryType.bodyPart:
        lessons.value = AppData.getBodyPartLessons();
        break;
      case CategoryType.flower:
        lessons.value = AppData.getFlowerLessons();
        break;
      case CategoryType.vegetable:
        lessons.value = AppData.getVegetableLessons();
        break;
      case CategoryType.vehicle:
        lessons.value = AppData.getVehicleLessons();
        break;
      case CategoryType.accessory:
        lessons.value = AppData.getAccessoryLessons();
        break;
      case CategoryType.clothes:
        lessons.value = AppData.getClothesLessons();
        break;
      case CategoryType.math:
        lessons.value = AppData.getMathLessons();
        break;
      case CategoryType.quiz:
        lessons.value = AppData.getMixedLessons();
        break;
      default:
        lessons.value = [];
    }
  }

  LessonModel get currentLesson => lessons[currentIndex.value];

  // Check if current lesson is an alphabet lesson (for mixed mode)
  bool get isAlphabetLesson {
    final title = currentLesson.title.trim().toUpperCase();
    // Check if it's a single letter A-Z
    return title.length == 1 && 
           title.codeUnitAt(0) >= 65 && 
           title.codeUnitAt(0) <= 90;
  }

  Future<void> previousLesson() async {
    if (currentIndex.value > 0) {
      await Get.find<TtsService>().stop();
      isAnimating.value = true;
      currentIndex.value--;
      updateCaption();
      await Future.delayed(const Duration(milliseconds: 300));
      isAnimating.value = false;
    }
  }

  Future<void> nextLesson() async {
    if (currentIndex.value < lessons.length - 1) {
      await Get.find<TtsService>().stop();
      isAnimating.value = true;
      currentIndex.value++;
      updateCaption();
      _celebrateProgress();
      await Future.delayed(const Duration(milliseconds: 300));
      isAnimating.value = false;
    } else {
      // Completed all lessons
      celebrateCompletion();
    }
  }

  void _celebrateProgress() {
    mascotEmotion.value = MascotEmotion.clapping;
    showStarReward.value = true;
    completedLessons.value++;
    if (Get.isRegistered<AudioService>()) {
      Get.find<AudioService>().playRewardStar();
    }
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      showStarReward.value = false;
      mascotEmotion.value = MascotEmotion.happy;
    });
  }

  void celebrateCompletion() {
    if (Get.isRegistered<AudioService>()) {
      Get.find<AudioService>().playRewardCelebration();
    }
    mascotEmotion.value = MascotEmotion.celebrating;
    showStarReward.value = true;
    if (Get.isRegistered<AdManager>()) {
      Get.find<AdManager>().onActivityCompleted(major: true);
    }
  }

  void onImageTap() {
    mascotEmotion.value = MascotEmotion.happy;
    playAudio();
  }

  void onLetterTap() {
    mascotEmotion.value = MascotEmotion.encouraging;
    playAudio();
  }

  Future<void> playAudio() async {
    final tts = Get.find<TtsService>();
    if (tts.isPlaying.value) {
      await tts.stop();
    } else {
      // Check if it's an alphabet lesson (either alphabet category or alphabet in mixed mode)
      if (category.type == CategoryType.alphabet || 
          (category.type == CategoryType.quiz && isAlphabetLesson)) {
        await tts.speakLetter(currentLesson.title);
      } else if (category.type == CategoryType.number) {
        final number = int.tryParse(currentLesson.title) ?? 1;
        await tts.speakNumber(number);
      } else {
        await tts.speakWord(currentLesson.title);
      }
    }
  }

  @override
  void onClose() {
    Get.find<TtsService>().stop();
    super.onClose();
  }
}
