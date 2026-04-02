import 'package:get/get.dart';
import '../models/category_model.dart';
import '../models/quiz_model.dart';
import '../data/app_data.dart';
import '../services/audio_service.dart';
import '../services/tts_service.dart';
import '../monetization/ad_manager.dart';

class QuizController extends GetxController {
  final CategoryModel category;
  
  QuizController(this.category);

  final RxInt currentIndex = 0.obs;
  final RxInt selectedAnswer = (-1).obs;
  final RxInt score = 0.obs;
  final RxList<QuizModel> quizzes = <QuizModel>[].obs;
  final RxBool showConfetti = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadQuizzes();
    _updateCaption();
  }

  void _updateCaption() {
    if (quizzes.isEmpty) return;
    final tts = Get.find<TtsService>();

    if (isAlphabetQuestion && alphabetLetter != null) {
      // Use the same word mapping as learning screen
      final words = {
        'A': 'Apple', 'B': 'Bear', 'C': 'Cat', 'D': 'Dog',
        'E': 'Elephant', 'F': 'Frog', 'G': 'Giraffe', 'H': 'Horse',
        'I': 'Iguana', 'J': 'Juice', 'K': 'Kangaroo', 'L': 'Llama',
        'M': 'Monkey', 'N': 'Nest', 'O': 'Orange', 'P': 'Penguin',
        'Q': 'Queen', 'R': 'Rabbit', 'S': 'Snake', 'T': 'Tiger',
        'U': 'Unicorn', 'V': 'Violin', 'W': 'Whale', 'X': 'X-ray',
        'Y': 'Yacht', 'Z': 'Zebra',
      };
      final letter = alphabetLetter!.toUpperCase();
      final word = words[letter] ?? letter;
      tts.caption.value = '$letter for $word';
    } else {
      tts.caption.value = currentQuiz.question;
    }
  }

  void _loadQuizzes() {
    switch (category.type) {
      case CategoryType.alphabet:
        quizzes.value = AppData.getAlphabetQuizzes();
        break;
      case CategoryType.number:
        quizzes.value = AppData.getNumberQuizzes();
        break;
      case CategoryType.shape:
        quizzes.value = AppData.getShapeQuizzes();
        break;
      case CategoryType.color:
        quizzes.value = AppData.getColorQuizzes();
        break;
      case CategoryType.animal:
        quizzes.value = AppData.getAnimalQuizzes();
        break;
      case CategoryType.fruit:
        quizzes.value = AppData.getFruitQuizzes();
        break;
      case CategoryType.flower:
        quizzes.value = AppData.getFlowerQuizzes();
        break;
      case CategoryType.vegetable:
        quizzes.value = AppData.getVegetableQuizzes();
        break;
      case CategoryType.vehicle:
        quizzes.value = AppData.getVehicleQuizzes();
        break;
      case CategoryType.accessory:
        quizzes.value = AppData.getAccessoryQuizzes();
        break;
      case CategoryType.clothes:
        quizzes.value = AppData.getClothesQuizzes();
        break;
      case CategoryType.quiz:
        quizzes.value = AppData.getMixedQuizzes();
        break;
      default:
        quizzes.value = AppData.getAlphabetQuizzes();
    }
  }

  QuizModel get currentQuiz => quizzes[currentIndex.value];

  // Check if current quiz question is an alphabet question
  bool get isAlphabetQuestion {
    final question = currentQuiz.question.toLowerCase();
    final options = currentQuiz.options;
    
    // Check if question asks about letters and options contain "for" pattern
    if (question.contains('which letter') && 
        question.contains('for') &&
        options.any((opt) => opt.contains(' for '))) {
      return true;
    }
    
    // Also check if any option matches "Letter for Word" pattern
    if (options.any((opt) {
      final parts = opt.split(' for ');
      if (parts.length == 2) {
        final letter = parts[0].trim();
        return letter.length == 1 && letter.toUpperCase() != letter.toLowerCase();
      }
      return false;
    })) {
      return true;
    }
    
    return false;
  }

  // Get the letter from alphabet question (e.g., "A for Apple" -> "A")
  String? get alphabetLetter {
    if (!isAlphabetQuestion) return null;
    
    // Find the correct answer option
    final correctOption = currentQuiz.options[currentQuiz.correctAnswer];
    final parts = correctOption.split(' for ');
    if (parts.length == 2) {
      return parts[0].trim();
    }
    return null;
  }

  void selectAnswer(int index) {
    selectedAnswer.value = index;
  }

  Future<void> checkAnswer() async {
    if (selectedAnswer.value == -1) return;

    final isCorrect = selectedAnswer.value == currentQuiz.correctAnswer;
    final wasLast = currentIndex.value == quizzes.length - 1;
    final sfx = Get.find<AudioService>();
    final tts = Get.find<TtsService>();

    if (isCorrect) {
      score.value++;
      if (wasLast) {
        await sfx.playRewardCelebration();
      } else {
        await sfx.playCoinPickup();
      }
      if (wasLast && Get.isRegistered<AdManager>()) {
        Get.find<AdManager>().onActivityCompleted(major: true);
      }
      await tts.speakWord('Correct! Great job!');
      showConfetti.value = true;
      Future.delayed(const Duration(seconds: 1), () => showConfetti.value = false);
    } else {
      // Tap SFX already played from [AnimatedButton].
      await tts.speakWord('Try again');
    }
  }

  void nextQuestion() {
    if (currentIndex.value < quizzes.length - 1) {
      currentIndex.value++;
      selectedAnswer.value = -1;
      _updateCaption();
    }
  }

  bool get isLastQuestion => currentIndex.value >= quizzes.length - 1;

  void reset() {
    currentIndex.value = 0;
    selectedAnswer.value = -1;
    score.value = 0;
  }
}
