import 'package:flutter/cupertino.dart';
import '../models/category_model.dart';
import '../models/lesson_model.dart';
import '../models/quiz_model.dart';
import '../constants/app_colors.dart';

class AppData {
  AppData._();

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
        id: 'alphabet',
        title: 'Alphabets',
        icon: '𝔸',
        color: AppColors.primary,
        type: CategoryType.alphabet,
        description: 'Learn A to Z with fun tracing',
      ),
      CategoryModel(
        id: 'numbers',
        title: 'Numbers',
        icon: '𝟙',
        color: AppColors.secondary,
        type: CategoryType.number,
        description: 'Count from 1 to 100',
      ),
      CategoryModel(
        id: 'shapes',
        title: 'Shapes',
        icon: '🔷',
        color: AppColors.accent,
        type: CategoryType.shape,
        description: 'Learn circles, squares & more',
      ),
      CategoryModel(
        id: 'colors',
        title: 'Colors',
        icon: '🎨',
        color: AppColors.warning,
        type: CategoryType.color,
        description: 'Discover rainbow colors',
      ),
      CategoryModel(
        id: 'animals',
        title: 'Animals',
        icon: '🐉',
        color: AppColors.success,
        type: CategoryType.animal,
        description: 'Meet amazing animals',
      ),
      CategoryModel(
        id: 'fruits',
        title: 'Fruits',
        icon: '🍎',
        color: AppColors.error,
        type: CategoryType.fruit,
        description: 'Learn healthy fruits',
      ),
      CategoryModel(
        id: 'body',
        title: 'Body Parts',
        icon: '👤',
        color: AppColors.info,
        type: CategoryType.bodyPart,
        description: 'Know your body',
      ),

      CategoryModel(
        id: 'flowers',
        title: 'Flowers',
        icon: '🌸',
        color: Color(0xFFFF6B9D),
        type: CategoryType.flower,
        description: 'Beautiful flowers',
      ),
      CategoryModel(
        id: 'vegetables',
        title: 'Vegetables',
        icon: '🥕',
        color: Color(0xFF4CAF50),
        type: CategoryType.vegetable,
        description: 'Healthy vegetables',
      ),
      CategoryModel(
        id: 'vehicles',
        title: 'Vehicles',
        icon: '🚗',
        color: Color(0xFFFF9800),
        type: CategoryType.vehicle,
        description: 'Cars, trucks & more',
      ),
      CategoryModel(
        id: 'accessories',
        title: 'Accessories',
        icon: '👓',
        color: Color(0xFF9C27B0),
        type: CategoryType.accessory,
        description: 'Fun accessories',
      ),
      CategoryModel(
        id: 'clothes',
        title: 'Clothes',
        icon: '👕',
        color: Color(0xFFE91E63),
        type: CategoryType.clothes,
        description: 'Wearable items',
      ),
      CategoryModel(
        id: 'quiz',
        title: 'Quiz Time',
        icon: '🎯',
        color: AppColors.primaryDark,
        type: CategoryType.quiz,
        description: 'Test your knowledge',
      ),
      CategoryModel(
        id: 'math',
        title: 'Math Tables',
        icon: '✖️',
        color: AppColors.secondaryDark,
        type: CategoryType.math,
        description: 'Master multiplication',
        isPremium: true,
      ),
    ];
  }

  static List<LessonModel> getAlphabetLessons() {
    final emojis = [
      '🍎', // A - Apple
      '🐻', // B - Bear
      '🐱', // C - Cat
      '🐶', // D - Dog
      '🐘', // E - Elephant
      '🐸', // F - Frog
      '🦒', // G - Giraffe
      '🐴', // H - Horse
      '🦎', // I - Iguana
      '🧃', // J - Juice
      '🦘', // K - Kangaroo
      '🦙', // L - Llama
      '🐵', // M - Monkey
      '🪺', // N - Nest
      '🍊', // O - Orange
      '🐧', // P - Penguin
      '👸', // Q - Queen
      '🐰', // R - Rabbit
      '🐍', // S - Snake
      '🐯', // T - Tiger
      '🦄', // U - Unicorn
      '🎻', // V - Violin
      '🐋', // W - Whale
      '🩻', // X - X-ray
      '⛵', // Y - Yacht
      '🦓', // Z - Zebra
    ];
    return List.generate(26, (index) {
      final letter = String.fromCharCode(65 + index);
      return LessonModel(
        id: 'alphabet_$letter',
        title: letter,
        image: emojis[index],
        audio: '',
        description: 'Letter $letter',
      );
    });
  }

  static List<LessonModel> getNumberLessons() {
    final numberEmojis = [
      '1️⃣',
      '2️⃣',
      '3️⃣',
      '4️⃣',
      '5️⃣',
      '6️⃣',
      '7️⃣',
      '8️⃣',
      '9️⃣',
      '🔟',
    ];
    return List.generate(10, (index) {
      final number = index + 1;
      return LessonModel(
        id: 'number_$number',
        title: number.toString(),
        image: numberEmojis[number - 1],
        audio: '',
        description: 'Number $number',
      );
    });
  }

  static List<QuizModel> getAlphabetQuizzes() {
    // Word mapping matching the learning screen
    final words = {
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

    // Emoji mapping
    final emojis = {
      'A': '🍎',
      'B': '🐻',
      'C': '🐱',
      'D': '🐶',
      'E': '🐘',
      'F': '🐸',
      'G': '🦒',
      'H': '🐴',
      'I': '🦎',
      'J': '🧃',
      'K': '🦘',
      'L': '🦙',
      'M': '🐵',
      'N': '🪺',
      'O': '🍊',
      'P': '🐧',
      'Q': '👸',
      'R': '🐰',
      'S': '🐍',
      'T': '🐯',
      'U': '🦄',
      'V': '🎻',
      'W': '🐋',
      'X': '🩻',
      'Y': '⛵',
      'Z': '🦓',
    };

    final List<QuizModel> quizzes = [];
    final letters = words.keys.toList();

    // Create quiz for each letter A-Z
    for (int i = 0; i < letters.length; i++) {
      final letter = letters[i];
      final word = words[letter]!;
      final emoji = emojis[letter]!;

      // Create options with the correct answer and 3 random wrong answers
      final options = <String>[];
      options.add('$letter for $word'); // Correct answer

      // Add 3 wrong options from other letters
      final wrongLetters = List<String>.from(letters);
      wrongLetters.remove(letter);
      wrongLetters.shuffle();

      for (int j = 0; j < 3 && j < wrongLetters.length; j++) {
        final wrongLetter = wrongLetters[j];
        options.add('$wrongLetter for ${words[wrongLetter]}');
      }

      // Shuffle options but remember correct answer index
      final correctIndex = 0;
      options.shuffle();
      final correctAnswer = options.indexOf('$letter for $word');

      quizzes.add(
        QuizModel(
          id: 'alpha_${i + 1}',
          question: 'Which letter is for $word?',
          options: options,
          correctAnswer: correctAnswer,
          image: emoji,
        ),
      );
    }

    return quizzes;
  }

  static List<QuizModel> getNumberQuizzes() {
    return [
      QuizModel(
        id: 'num_1',
        question: 'What comes after 1?',
        options: ['0', '2', '3', '4'],
        correctAnswer: 1,
        image: '🔢',
      ),
      QuizModel(
        id: 'num_2',
        question: 'How many apples? 🍎🍎🍎',
        options: ['2', '3', '4', '5'],
        correctAnswer: 1,
        image: '🍎',
      ),
      QuizModel(
        id: 'num_3',
        question: 'What comes after 5?',
        options: ['4', '6', '7', '8'],
        correctAnswer: 1,
        image: '🔢',
      ),
      QuizModel(
        id: 'num_4',
        question: 'Count the stars: ⭐⭐⭐⭐',
        options: ['3', '4', '5', '6'],
        correctAnswer: 1,
        image: '⭐',
      ),
      QuizModel(
        id: 'num_5',
        question: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: 1,
        image: '🔢',
      ),
      QuizModel(
        id: 'num_6',
        question: 'What comes before 5?',
        options: ['3', '4', '5', '6'],
        correctAnswer: 1,
        image: '🔢',
      ),
      QuizModel(
        id: 'num_7',
        question: 'How many ducks? 🦆🦆',
        options: ['1', '2', '3', '4'],
        correctAnswer: 1,
        image: '🦆',
      ),
      QuizModel(
        id: 'num_8',
        question: 'What is 3 + 2?',
        options: ['4', '5', '6', '7'],
        correctAnswer: 1,
        image: '🔢',
      ),
      QuizModel(
        id: 'num_9',
        question: 'Which is the biggest number?',
        options: ['2', '5', '9', '1'],
        correctAnswer: 2,
        image: '🔢',
      ),
      QuizModel(
        id: 'num_10',
        question: 'How many stars? ⭐⭐⭐⭐⭐',
        options: ['4', '5', '6', '7'],
        correctAnswer: 1,
        image: '⭐',
      ),
    ];
  }

  static List<LessonModel> getShapeLessons() {
    return [
      const LessonModel(
        id: 'circle',
        title: 'Circle',
        image: '⭕',
        audio: '',
        description: 'Round shape',
      ),
      const LessonModel(
        id: 'square',
        title: 'Square',
        image: '⬜',
        audio: '',
        description: 'Four equal sides',
      ),
      const LessonModel(
        id: 'triangle',
        title: 'Triangle',
        image: '🔺',
        audio: '',
        description: 'Three sides',
      ),
      const LessonModel(
        id: 'star',
        title: 'Star',
        image: '⭐',
        audio: '',
        description: 'Shining star',
      ),
      const LessonModel(
        id: 'heart',
        title: 'Heart',
        image: '❤️',
        audio: '',
        description: 'Love shape',
      ),
      const LessonModel(
        id: 'diamond',
        title: 'Diamond',
        image: '💎',
        audio: '',
        description: 'Sparkling gem',
      ),
      const LessonModel(
        id: 'rectangle',
        title: 'Rectangle',
        image: '▭',
        audio: '',
        description: 'Long shape',
      ),
      const LessonModel(
        id: 'oval',
        title: 'Oval',
        image: '🥚',
        audio: '',
        description: 'Egg shape',
      ),
      const LessonModel(
        id: 'pentagon',
        title: 'Pentagon',
        image: '⬟',
        audio: '',
        description: 'Five sides',
      ),
      const LessonModel(
        id: 'hexagon',
        title: 'Hexagon',
        image: '⬡',
        audio: '',
        description: 'Six sides',
      ),
      const LessonModel(
        id: 'crescent',
        title: 'Crescent',
        image: '🌙',
        audio: '',
        description: 'Moon shape',
      ),
      const LessonModel(
        id: 'ring',
        title: 'Ring',
        image: '💍',
        audio: '',
        description: 'Circular ring',
      ),
      const LessonModel(
        id: 'sparkle',
        title: 'Sparkle',
        image: '✨',
        audio: '',
        description: 'Shiny sparkle',
      ),
      const LessonModel(
        id: 'cross',
        title: 'Cross',
        image: '➕',
        audio: '',
        description: 'Plus cross',
      ),
    ];
  }

  static List<LessonModel> getColorLessons() {
    return [
      const LessonModel(
        id: 'red',
        title: 'Red',
        image: '🔴',
        audio: '',
        description: 'Red color',
      ),
      const LessonModel(
        id: 'blue',
        title: 'Blue',
        image: '🔵',
        audio: '',
        description: 'Blue color',
      ),
      const LessonModel(
        id: 'green',
        title: 'Green',
        image: '🟢',
        audio: '',
        description: 'Green color',
      ),
      const LessonModel(
        id: 'yellow',
        title: 'Yellow',
        image: '🟡',
        audio: '',
        description: 'Yellow color',
      ),
      const LessonModel(
        id: 'orange',
        title: 'Orange',
        image: '🟠',
        audio: '',
        description: 'Orange color',
      ),
      const LessonModel(
        id: 'purple',
        title: 'Purple',
        image: '🟣',
        audio: '',
        description: 'Purple color',
      ),
      const LessonModel(
        id: 'pink',
        title: 'Pink',
        image: '🩷',
        audio: '',
        description: 'Pink color',
      ),
      const LessonModel(
        id: 'brown',
        title: 'Brown',
        image: '🟤',
        audio: '',
        description: 'Brown color',
      ),
      const LessonModel(
        id: 'white',
        title: 'White',
        image: '⚪',
        audio: '',
        description: 'White color',
      ),
      const LessonModel(
        id: 'black',
        title: 'Black',
        image: '⚫',
        audio: '',
        description: 'Black color',
      ),
      const LessonModel(
        id: 'rainbow',
        title: 'Rainbow',
        image: '🌈',
        audio: '',
        description: 'All colors',
      ),
      const LessonModel(
        id: 'gold',
        title: 'Gold',
        image: '🟨',
        audio: '',
        description: 'Golden color',
      ),
    ];
  }

  static List<LessonModel> getAnimalLessons() {
    return [
      const LessonModel(
        id: 'lion',
        title: 'Lion',
        image: '🦁',
        audio: '',
        description: 'King of jungle',
      ),
      const LessonModel(
        id: 'elephant',
        title: 'Elephant',
        image: '🐘',
        audio: '',
        description: 'Big animal',
      ),
      const LessonModel(
        id: 'tiger',
        title: 'Tiger',
        image: '🐯',
        audio: '',
        description: 'Striped cat',
      ),
      const LessonModel(
        id: 'bear',
        title: 'Bear',
        image: '🐻',
        audio: '',
        description: 'Furry friend',
      ),
      const LessonModel(
        id: 'panda',
        title: 'Panda',
        image: '🐼',
        audio: '',
        description: 'Black and white',
      ),
      const LessonModel(
        id: 'monkey',
        title: 'Monkey',
        image: '🐵',
        audio: '',
        description: 'Playful animal',
      ),
      const LessonModel(
        id: 'giraffe',
        title: 'Giraffe',
        image: '🦒',
        audio: '',
        description: 'Tall neck',
      ),
      const LessonModel(
        id: 'zebra',
        title: 'Zebra',
        image: '🦓',
        audio: '',
        description: 'Striped horse',
      ),
      const LessonModel(
        id: 'hippo',
        title: 'Hippo',
        image: '🦛',
        audio: '',
        description: 'Water animal',
      ),
      const LessonModel(
        id: 'crocodile',
        title: 'Crocodile',
        image: '🐊',
        audio: '',
        description: 'Sharp teeth',
      ),
      const LessonModel(
        id: 'dog',
        title: 'Dog',
        image: '🐶',
        audio: '',
        description: 'Best friend',
      ),
      const LessonModel(
        id: 'cat',
        title: 'Cat',
        image: '🐱',
        audio: '',
        description: 'Cute pet',
      ),
      const LessonModel(
        id: 'rabbit',
        title: 'Rabbit',
        image: '🐰',
        audio: '',
        description: 'Hopping bunny',
      ),
      const LessonModel(
        id: 'fox',
        title: 'Fox',
        image: '🦊',
        audio: '',
        description: 'Clever animal',
      ),
      const LessonModel(
        id: 'wolf',
        title: 'Wolf',
        image: '🐺',
        audio: '',
        description: 'Wild dog',
      ),
      const LessonModel(
        id: 'pig',
        title: 'Pig',
        image: '🐷',
        audio: '',
        description: 'Pink animal',
      ),
      const LessonModel(
        id: 'cow',
        title: 'Cow',
        image: '🐮',
        audio: '',
        description: 'Farm animal',
      ),
      const LessonModel(
        id: 'horse',
        title: 'Horse',
        image: '🐴',
        audio: '',
        description: 'Fast runner',
      ),
      const LessonModel(
        id: 'sheep',
        title: 'Sheep',
        image: '🐑',
        audio: '',
        description: 'Woolly animal',
      ),
      const LessonModel(
        id: 'goat',
        title: 'Goat',
        image: '🐐',
        audio: '',
        description: 'Mountain climber',
      ),
      const LessonModel(
        id: 'deer',
        title: 'Deer',
        image: '🦌',
        audio: '',
        description: 'Forest animal',
      ),
      const LessonModel(
        id: 'rhino',
        title: 'Rhino',
        image: '🦏',
        audio: '',
        description: 'Big horn',
      ),
      const LessonModel(
        id: 'camel',
        title: 'Camel',
        image: '🐪',
        audio: '',
        description: 'Desert animal',
      ),
      const LessonModel(
        id: 'llama',
        title: 'Llama',
        image: '🦙',
        audio: '',
        description: 'Fluffy animal',
      ),
      const LessonModel(
        id: 'kangaroo',
        title: 'Kangaroo',
        image: '🦘',
        audio: '',
        description: 'Hopping marsupial',
      ),
      const LessonModel(
        id: 'koala',
        title: 'Koala',
        image: '🐨',
        audio: '',
        description: 'Tree hugger',
      ),
      const LessonModel(
        id: 'sloth',
        title: 'Sloth',
        image: '🦥',
        audio: '',
        description: 'Slow mover',
      ),
      const LessonModel(
        id: 'otter',
        title: 'Otter',
        image: '🦦',
        audio: '',
        description: 'Water player',
      ),
      const LessonModel(
        id: 'beaver',
        title: 'Beaver',
        image: '🦫',
        audio: '',
        description: 'Builder',
      ),
      const LessonModel(
        id: 'mouse',
        title: 'Mouse',
        image: '🐭',
        audio: '',
        description: 'Small rodent',
      ),
      const LessonModel(
        id: 'hamster',
        title: 'Hamster',
        image: '🐹',
        audio: '',
        description: 'Cute pet',
      ),
      const LessonModel(
        id: 'rat',
        title: 'Rat',
        image: '🐀',
        audio: '',
        description: 'Small animal',
      ),
      const LessonModel(
        id: 'chipmunk',
        title: 'Chipmunk',
        image: '🐿️',
        audio: '',
        description: 'Cheeky animal',
      ),
      const LessonModel(
        id: 'hedgehog',
        title: 'Hedgehog',
        image: '🦔',
        audio: '',
        description: 'Spiky friend',
      ),
      const LessonModel(
        id: 'bat',
        title: 'Bat',
        image: '🦇',
        audio: '',
        description: 'Night flyer',
      ),
      const LessonModel(
        id: 'eagle',
        title: 'Eagle',
        image: '🦅',
        audio: '',
        description: 'Flying high',
      ),
      const LessonModel(
        id: 'owl',
        title: 'Owl',
        image: '🦉',
        audio: '',
        description: 'Wise bird',
      ),
      const LessonModel(
        id: 'duck',
        title: 'Duck',
        image: '🦆',
        audio: '',
        description: 'Water bird',
      ),
      const LessonModel(
        id: 'chicken',
        title: 'Chicken',
        image: '🐔',
        audio: '',
        description: 'Farm bird',
      ),
      const LessonModel(
        id: 'rooster',
        title: 'Rooster',
        image: '🐓',
        audio: '',
        description: 'Morning caller',
      ),
      const LessonModel(
        id: 'turkey',
        title: 'Turkey',
        image: '🦃',
        audio: '',
        description: 'Thanksgiving bird',
      ),
      const LessonModel(
        id: 'peacock',
        title: 'Peacock',
        image: '🦚',
        audio: '',
        description: 'Beautiful tail',
      ),
      const LessonModel(
        id: 'flamingo',
        title: 'Flamingo',
        image: '🦩',
        audio: '',
        description: 'Pink bird',
      ),
      const LessonModel(
        id: 'penguin',
        title: 'Penguin',
        image: '🐧',
        audio: '',
        description: 'Ice walker',
      ),
      const LessonModel(
        id: 'dove',
        title: 'Dove',
        image: '🕊️',
        audio: '',
        description: 'Peace bird',
      ),
      const LessonModel(
        id: 'swan',
        title: 'Swan',
        image: '🦢',
        audio: '',
        description: 'Elegant bird',
      ),
      const LessonModel(
        id: 'frog',
        title: 'Frog',
        image: '🐸',
        audio: '',
        description: 'Hopping green',
      ),
      const LessonModel(
        id: 'turtle',
        title: 'Turtle',
        image: '🐢',
        audio: '',
        description: 'Slow shell',
      ),
      const LessonModel(
        id: 'lizard',
        title: 'Lizard',
        image: '🦎',
        audio: '',
        description: 'Scaly friend',
      ),
      const LessonModel(
        id: 'snake',
        title: 'Snake',
        image: '🐍',
        audio: '',
        description: 'Slithering',
      ),
      const LessonModel(
        id: 'dragon',
        title: 'Dragon',
        image: '🐲',
        audio: '',
        description: 'Mythical creature',
      ),
      const LessonModel(
        id: 'sauropod',
        title: 'Dinosaur',
        image: '🦕',
        audio: '',
        description: 'Long neck',
      ),
      const LessonModel(
        id: 't-rex',
        title: 'T-Rex',
        image: '🦖',
        audio: '',
        description: 'Big dinosaur',
      ),
      const LessonModel(
        id: 'whale',
        title: 'Whale',
        image: '🐋',
        audio: '',
        description: 'Big ocean',
      ),
      const LessonModel(
        id: 'dolphin',
        title: 'Dolphin',
        image: '🐬',
        audio: '',
        description: 'Smart swimmer',
      ),
      const LessonModel(
        id: 'shark',
        title: 'Shark',
        image: '🦈',
        audio: '',
        description: 'Ocean predator',
      ),
      const LessonModel(
        id: 'fish',
        title: 'Fish',
        image: '🐟',
        audio: '',
        description: 'Water swimmer',
      ),
      const LessonModel(
        id: 'tropical_fish',
        title: 'Tropical Fish',
        image: '🐠',
        audio: '',
        description: 'Colorful fish',
      ),
      const LessonModel(
        id: 'blowfish',
        title: 'Blowfish',
        image: '🐡',
        audio: '',
        description: 'Puffy fish',
      ),
      const LessonModel(
        id: 'octopus',
        title: 'Octopus',
        image: '🐙',
        audio: '',
        description: 'Eight arms',
      ),
      const LessonModel(
        id: 'squid',
        title: 'Squid',
        image: '🦑',
        audio: '',
        description: 'Sea creature',
      ),
      const LessonModel(
        id: 'shrimp',
        title: 'Shrimp',
        image: '🦐',
        audio: '',
        description: 'Small sea',
      ),
      const LessonModel(
        id: 'lobster',
        title: 'Lobster',
        image: '🦞',
        audio: '',
        description: 'Red shell',
      ),
      const LessonModel(
        id: 'crab',
        title: 'Crab',
        image: '🦀',
        audio: '',
        description: 'Side walker',
      ),
      const LessonModel(
        id: 'seal',
        title: 'Seal',
        image: '🦭',
        audio: '',
        description: 'Ocean friend',
      ),
      const LessonModel(
        id: 'butterfly',
        title: 'Butterfly',
        image: '🦋',
        audio: '',
        description: 'Colorful wings',
      ),
      const LessonModel(
        id: 'bug',
        title: 'Bug',
        image: '🐛',
        audio: '',
        description: 'Small insect',
      ),
      const LessonModel(
        id: 'ant',
        title: 'Ant',
        image: '🐜',
        audio: '',
        description: 'Hard worker',
      ),
      const LessonModel(
        id: 'bee',
        title: 'Bee',
        image: '🐝',
        audio: '',
        description: 'Honey maker',
      ),
      const LessonModel(
        id: 'beetle',
        title: 'Beetle',
        image: '🪲',
        audio: '',
        description: 'Shiny shell',
      ),
      const LessonModel(
        id: 'cockroach',
        title: 'Cockroach',
        image: '🪳',
        audio: '',
        description: 'Small bug',
      ),
      const LessonModel(
        id: 'spider',
        title: 'Spider',
        image: '🕷️',
        audio: '',
        description: 'Eight legs',
      ),
      const LessonModel(
        id: 'spider_web',
        title: 'Spider Web',
        image: '🕸️',
        audio: '',
        description: 'Web maker',
      ),
      const LessonModel(
        id: 'scorpion',
        title: 'Scorpion',
        image: '🦂',
        audio: '',
        description: 'Stinger',
      ),
      const LessonModel(
        id: 'mosquito',
        title: 'Mosquito',
        image: '🦟',
        audio: '',
        description: 'Buzzing bug',
      ),
      const LessonModel(
        id: 'fly',
        title: 'Fly',
        image: '🪰',
        audio: '',
        description: 'Flying bug',
      ),
      const LessonModel(
        id: 'worm',
        title: 'Worm',
        image: '🪱',
        audio: '',
        description: 'Underground',
      ),
      const LessonModel(
        id: 'microbe',
        title: 'Microbe',
        image: '🦠',
        audio: '',
        description: 'Tiny life',
      ),
    ];
  }

  static List<LessonModel> getFruitLessons() {
    return [
      const LessonModel(
        id: 'apple',
        title: 'Apple',
        image: '🍎',
        audio: '',
        description: 'Red fruit',
      ),
      const LessonModel(
        id: 'banana',
        title: 'Banana',
        image: '🍌',
        audio: '',
        description: 'Yellow fruit',
      ),
      const LessonModel(
        id: 'orange',
        title: 'Orange',
        image: '🍊',
        audio: '',
        description: 'Orange fruit',
      ),
      const LessonModel(
        id: 'grape',
        title: 'Grape',
        image: '🍇',
        audio: '',
        description: 'Purple fruit',
      ),
      const LessonModel(
        id: 'strawberry',
        title: 'Strawberry',
        image: '🍓',
        audio: '',
        description: 'Red berry',
      ),
      const LessonModel(
        id: 'watermelon',
        title: 'Watermelon',
        image: '🍉',
        audio: '',
        description: 'Big fruit',
      ),
      const LessonModel(
        id: 'pineapple',
        title: 'Pineapple',
        image: '🍍',
        audio: '',
        description: 'Tropical fruit',
      ),
      const LessonModel(
        id: 'mango',
        title: 'Mango',
        image: '🥭',
        audio: '',
        description: 'Sweet fruit',
      ),
      const LessonModel(
        id: 'cherry',
        title: 'Cherry',
        image: '🍒',
        audio: '',
        description: 'Small red fruit',
      ),
      const LessonModel(
        id: 'peach',
        title: 'Peach',
        image: '🍑',
        audio: '',
        description: 'Fuzzy fruit',
      ),
      const LessonModel(
        id: 'pear',
        title: 'Pear',
        image: '🍐',
        audio: '',
        description: 'Green fruit',
      ),
      const LessonModel(
        id: 'kiwi',
        title: 'Kiwi',
        image: '🥝',
        audio: '',
        description: 'Fuzzy brown',
      ),
      const LessonModel(
        id: 'coconut',
        title: 'Coconut',
        image: '🥥',
        audio: '',
        description: 'Tropical nut',
      ),
      const LessonModel(
        id: 'avocado',
        title: 'Avocado',
        image: '🥑',
        audio: '',
        description: 'Green healthy',
      ),
      const LessonModel(
        id: 'tomato',
        title: 'Tomato',
        image: '🍅',
        audio: '',
        description: 'Red vegetable',
      ),
      const LessonModel(
        id: 'eggplant',
        title: 'Eggplant',
        image: '🍆',
        audio: '',
        description: 'Purple vegetable',
      ),
      const LessonModel(
        id: 'corn',
        title: 'Corn',
        image: '🌽',
        audio: '',
        description: 'Yellow kernels',
      ),
      const LessonModel(
        id: 'carrot',
        title: 'Carrot',
        image: '🥕',
        audio: '',
        description: 'Orange vegetable',
      ),
      const LessonModel(
        id: 'hot_pepper',
        title: 'Pepper',
        image: '🌶️',
        audio: '',
        description: 'Spicy vegetable',
      ),
      const LessonModel(
        id: 'cucumber',
        title: 'Cucumber',
        image: '🥒',
        audio: '',
        description: 'Green vegetable',
      ),
      const LessonModel(
        id: 'broccoli',
        title: 'Broccoli',
        image: '🥦',
        audio: '',
        description: 'Green tree',
      ),
      const LessonModel(
        id: 'mushroom',
        title: 'Mushroom',
        image: '🍄',
        audio: '',
        description: 'Forest food',
      ),
      const LessonModel(
        id: 'peanuts',
        title: 'Peanuts',
        image: '🥜',
        audio: '',
        description: 'Small nuts',
      ),
      const LessonModel(
        id: 'chestnut',
        title: 'Chestnut',
        image: '🌰',
        audio: '',
        description: 'Brown nut',
      ),
      const LessonModel(
        id: 'bread',
        title: 'Bread',
        image: '🍞',
        audio: '',
        description: 'Baked food',
      ),
      const LessonModel(
        id: 'croissant',
        title: 'Croissant',
        image: '🥐',
        audio: '',
        description: 'French bread',
      ),
      const LessonModel(
        id: 'baguette',
        title: 'Baguette',
        image: '🥖',
        audio: '',
        description: 'Long bread',
      ),
      const LessonModel(
        id: 'pretzel',
        title: 'Pretzel',
        image: '🥨',
        audio: '',
        description: 'Twisted snack',
      ),
      const LessonModel(
        id: 'bagel',
        title: 'Bagel',
        image: '🥯',
        audio: '',
        description: 'Round bread',
      ),
      const LessonModel(
        id: 'pancakes',
        title: 'Pancakes',
        image: '🥞',
        audio: '',
        description: 'Stacked breakfast',
      ),
      const LessonModel(
        id: 'waffle',
        title: 'Waffle',
        image: '🧇',
        audio: '',
        description: 'Square breakfast',
      ),
      const LessonModel(
        id: 'cheese',
        title: 'Cheese',
        image: '🧀',
        audio: '',
        description: 'Dairy food',
      ),
      const LessonModel(
        id: 'meat',
        title: 'Meat',
        image: '🍖',
        audio: '',
        description: 'Protein food',
      ),
      const LessonModel(
        id: 'poultry',
        title: 'Chicken',
        image: '🍗',
        audio: '',
        description: 'Chicken leg',
      ),
      const LessonModel(
        id: 'cut_meat',
        title: 'Steak',
        image: '🥩',
        audio: '',
        description: 'Red meat',
      ),
      const LessonModel(
        id: 'bacon',
        title: 'Bacon',
        image: '🥓',
        audio: '',
        description: 'Striped meat',
      ),
      const LessonModel(
        id: 'hamburger',
        title: 'Burger',
        image: '🍔',
        audio: '',
        description: 'Fast food',
      ),
      const LessonModel(
        id: 'fries',
        title: 'Fries',
        image: '🍟',
        audio: '',
        description: 'Potato sticks',
      ),
      const LessonModel(
        id: 'pizza',
        title: 'Pizza',
        image: '🍕',
        audio: '',
        description: 'Italian food',
      ),
      const LessonModel(
        id: 'hotdog',
        title: 'Hot Dog',
        image: '🌭',
        audio: '',
        description: 'Sausage bun',
      ),
      const LessonModel(
        id: 'sandwich',
        title: 'Sandwich',
        image: '🥪',
        audio: '',
        description: 'Bread layers',
      ),
      const LessonModel(
        id: 'taco',
        title: 'Taco',
        image: '🌮',
        audio: '',
        description: 'Mexican food',
      ),
      const LessonModel(
        id: 'burrito',
        title: 'Burrito',
        image: '🌯',
        audio: '',
        description: 'Wrapped food',
      ),
      const LessonModel(
        id: 'tamale',
        title: 'Tamale',
        image: '🫔',
        audio: '',
        description: 'Wrapped corn',
      ),
      const LessonModel(
        id: 'stuffed_flatbread',
        title: 'Flatbread',
        image: '🫓',
        audio: '',
        description: 'Stuffed bread',
      ),
      const LessonModel(
        id: 'falafel',
        title: 'Falafel',
        image: '🧆',
        audio: '',
        description: 'Chickpea ball',
      ),
      const LessonModel(
        id: 'egg',
        title: 'Egg',
        image: '🥚',
        audio: '',
        description: 'Chicken egg',
      ),
      const LessonModel(
        id: 'cooking',
        title: 'Cooking',
        image: '🍳',
        audio: '',
        description: 'Fried egg',
      ),
      const LessonModel(
        id: 'shallow_pan',
        title: 'Pan',
        image: '🥘',
        audio: '',
        description: 'Cooking pot',
      ),
      const LessonModel(
        id: 'pot',
        title: 'Pot',
        image: '🍲',
        audio: '',
        description: 'Stew pot',
      ),
      const LessonModel(
        id: 'fondue',
        title: 'Fondue',
        image: '🫕',
        audio: '',
        description: 'Melted cheese',
      ),
      const LessonModel(
        id: 'bowl',
        title: 'Bowl',
        image: '🥣',
        audio: '',
        description: 'Food bowl',
      ),
      const LessonModel(
        id: 'green_salad',
        title: 'Salad',
        image: '🥗',
        audio: '',
        description: 'Fresh greens',
      ),
      const LessonModel(
        id: 'popcorn',
        title: 'Popcorn',
        image: '🍿',
        audio: '',
        description: 'Movie snack',
      ),
      const LessonModel(
        id: 'butter',
        title: 'Butter',
        image: '🧈',
        audio: '',
        description: 'Dairy spread',
      ),
      const LessonModel(
        id: 'salt',
        title: 'Salt',
        image: '🧂',
        audio: '',
        description: 'Seasoning',
      ),
      const LessonModel(
        id: 'canned_food',
        title: 'Can',
        image: '🥫',
        audio: '',
        description: 'Canned food',
      ),
    ];
  }

  static List<LessonModel> getBodyPartLessons() {
    return [
      const LessonModel(
        id: 'head',
        title: 'Head',
        image: '👤',
        audio: '',
        description: 'Your head',
      ),
      const LessonModel(
        id: 'eyes',
        title: 'Eyes',
        image: '👀',
        audio: '',
        description: 'Two eyes',
      ),
      const LessonModel(
        id: 'ear',
        title: 'Ear',
        image: '👂',
        audio: '',
        description: 'To hear',
      ),
      const LessonModel(
        id: 'nose',
        title: 'Nose',
        image: '👃',
        audio: '',
        description: 'To smell',
      ),
      const LessonModel(
        id: 'mouth',
        title: 'Mouth',
        image: '👄',
        audio: '',
        description: 'To eat',
      ),
      const LessonModel(
        id: 'hand',
        title: 'Hand',
        image: '✋',
        audio: '',
        description: 'To hold',
      ),
      const LessonModel(
        id: 'foot',
        title: 'Foot',
        image: '🦶',
        audio: '',
        description: 'To walk',
      ),
      const LessonModel(
        id: 'arm',
        title: 'Arm',
        image: '💪',
        audio: '',
        description: 'Strong arm',
      ),
      const LessonModel(
        id: 'leg',
        title: 'Leg',
        image: '🦵',
        audio: '',
        description: 'To walk',
      ),
      const LessonModel(
        id: 'brain',
        title: 'Brain',
        image: '🧠',
        audio: '',
        description: 'Thinking',
      ),
      const LessonModel(
        id: 'tooth',
        title: 'Tooth',
        image: '🦷',
        audio: '',
        description: 'In mouth',
      ),
      const LessonModel(
        id: 'bone',
        title: 'Bone',
        image: '🦴',
        audio: '',
        description: 'Skeleton',
      ),
      const LessonModel(
        id: 'tongue',
        title: 'Tongue',
        image: '👅',
        audio: '',
        description: 'In mouth',
      ),
      const LessonModel(
        id: 'lips',
        title: 'Lips',
        image: '💋',
        audio: '',
        description: 'On mouth',
      ),
      const LessonModel(
        id: 'baby',
        title: 'Baby',
        image: '👶',
        audio: '',
        description: 'Little person',
      ),
      const LessonModel(
        id: 'child',
        title: 'Child',
        image: '🧒',
        audio: '',
        description: 'Young person',
      ),
      const LessonModel(
        id: 'person',
        title: 'Person',
        image: '🧑',
        audio: '',
        description: 'Adult person',
      ),
      const LessonModel(
        id: 'hair',
        title: 'Hair',
        image: '💇',
        audio: '',
        description: 'On head',
      ),
      const LessonModel(
        id: 'fingers',
        title: 'Fingers',
        image: '🤞',
        audio: '',
        description: 'On hand',
      ),
      const LessonModel(
        id: 'thumbs_up',
        title: 'Thumb',
        image: '👍',
        audio: '',
        description: 'Good job',
      ),
      const LessonModel(
        id: 'thumbs_down',
        title: 'Thumb Down',
        image: '👎',
        audio: '',
        description: 'Not good',
      ),
      const LessonModel(
        id: 'fist',
        title: 'Fist',
        image: '✊',
        audio: '',
        description: 'Closed hand',
      ),
      const LessonModel(
        id: 'wave',
        title: 'Wave',
        image: '👋',
        audio: '',
        description: 'Hello',
      ),
      const LessonModel(
        id: 'clap',
        title: 'Clap',
        image: '👏',
        audio: '',
        description: 'Applause',
      ),
      const LessonModel(
        id: 'open_hands',
        title: 'Open Hands',
        image: '👐',
        audio: '',
        description: 'Two hands',
      ),
      const LessonModel(
        id: 'palms_up',
        title: 'Palms Up',
        image: '🤲',
        audio: '',
        description: 'Hands together',
      ),
      const LessonModel(
        id: 'point_right',
        title: 'Point',
        image: '👉',
        audio: '',
        description: 'Pointing',
      ),
      const LessonModel(
        id: 'index_pointing',
        title: 'Index',
        image: '☝️',
        audio: '',
        description: 'One finger',
      ),
      const LessonModel(
        id: 'backhand_index',
        title: 'Backhand',
        image: '👆',
        audio: '',
        description: 'Pointing up',
      ),
      const LessonModel(
        id: 'middle_finger',
        title: 'Middle',
        image: '🖕',
        audio: '',
        description: 'Middle finger',
      ),
      const LessonModel(
        id: 'vulcan',
        title: 'Vulcan',
        image: '🖖',
        audio: '',
        description: 'Spock hand',
      ),
      const LessonModel(
        id: 'crossed_fingers',
        title: 'Crossed',
        image: '🤞',
        audio: '',
        description: 'Good luck',
      ),
      const LessonModel(
        id: 'love_you',
        title: 'Love You',
        image: '🤟',
        audio: '',
        description: 'I love you',
      ),
      const LessonModel(
        id: 'metal',
        title: 'Metal',
        image: '🤘',
        audio: '',
        description: 'Rock on',
      ),
      const LessonModel(
        id: 'call_me',
        title: 'Call Me',
        image: '🤙',
        audio: '',
        description: 'Phone me',
      ),
      const LessonModel(
        id: 'pinching',
        title: 'Pinch',
        image: '🤏',
        audio: '',
        description: 'Small amount',
      ),
      const LessonModel(
        id: 'ok_hand',
        title: 'OK',
        image: '👌',
        audio: '',
        description: 'Okay',
      ),
      const LessonModel(
        id: 'pinched_fingers',
        title: 'Pinched',
        image: '🤌',
        audio: '',
        description: 'Italian hand',
      ),
      const LessonModel(
        id: 'palm_down',
        title: 'Palm Down',
        image: '🤚',
        audio: '',
        description: 'Stop',
      ),
      const LessonModel(
        id: 'point_left',
        title: 'Point Left',
        image: '👈',
        audio: '',
        description: 'Left',
      ),
      const LessonModel(
        id: 'point_down',
        title: 'Point Down',
        image: '👇',
        audio: '',
        description: 'Down',
      ),
      const LessonModel(
        id: 'point_up_2',
        title: 'Point Up 2',
        image: '👆',
        audio: '',
        description: 'Up',
      ),
    ];
  }

  static List<LessonModel> getMathLessons() {
    return List.generate(10, (index) {
      final table = index + 1;
      return LessonModel(
        id: 'math_$table',
        title: '$table x Table',
        image: '✖️',
        audio: '',
        description: 'Multiplication table of $table',
        data: {'table': table},
      );
    });
  }

  static List<QuizModel> getShapeQuizzes() {
    return [
      QuizModel(
        id: 'shape_1',
        question: 'Which shape is round?',
        options: ['⭕ Circle', '⬜ Square', '🔺 Triangle', '⭐ Star'],
        correctAnswer: 0,
        image: '⭕',
      ),
      QuizModel(
        id: 'shape_2',
        question: 'How many sides does a triangle have?',
        options: ['2', '3', '4', '5'],
        correctAnswer: 1,
        image: '🔺',
      ),
      QuizModel(
        id: 'shape_3',
        question: 'Which shape has four equal sides?',
        options: ['⭕ Circle', '⬜ Square', '🔺 Triangle', '⭐ Star'],
        correctAnswer: 1,
        image: '⬜',
      ),
      QuizModel(
        id: 'shape_4',
        question: 'Which shape looks like an egg?',
        options: ['⭕ Circle', '🔺 Triangle', '🥚 Oval', '⭐ Star'],
        correctAnswer: 2,
        image: '🥚',
      ),
      QuizModel(
        id: 'shape_5',
        question: 'Which shape looks like the moon at night?',
        options: ['⬜ Square', '🌙 Crescent', '💎 Diamond', '⭕ Circle'],
        correctAnswer: 1,
        image: '🌙',
      ),
      QuizModel(
        id: 'shape_6',
        question: 'Which shape is a star?',
        options: ['⭕ Circle', '⬜ Square', '⭐ Star', '🔺 Triangle'],
        correctAnswer: 2,
        image: '⭐',
      ),
      QuizModel(
        id: 'shape_7',
        question: 'Which shape is used for a ring?',
        options: ['💍 Ring', '⬜ Square', '🔺 Triangle', '💎 Diamond'],
        correctAnswer: 0,
        image: '💍',
      ),
      QuizModel(
        id: 'shape_8',
        question: 'Which shape has three sides?',
        options: ['⭕ Circle', '⬜ Square', '🔺 Triangle', '⭐ Star'],
        correctAnswer: 2,
        image: '🔺',
      ),
    ];
  }

  static List<QuizModel> getColorQuizzes() {
    return [
      QuizModel(
        id: 'color_1',
        question: 'What color is an apple?',
        options: ['🔴 Red', '🔵 Blue', '🟢 Green', '🟡 Yellow'],
        correctAnswer: 0,
        image: '🍎',
      ),
      QuizModel(
        id: 'color_2',
        question: 'What color is the sky?',
        options: ['🔴 Red', '🔵 Blue', '🟢 Green', '🟡 Yellow'],
        correctAnswer: 1,
        image: '☁️',
      ),
      QuizModel(
        id: 'color_3',
        question: 'What color is grass?',
        options: ['🔴 Red', '🔵 Blue', '🟢 Green', '🟡 Yellow'],
        correctAnswer: 2,
        image: '🌱',
      ),
      QuizModel(
        id: 'color_4',
        question: 'What color is the sun?',
        options: ['🟡 Yellow', '🔵 Blue', '🟢 Green', '⚫ Black'],
        correctAnswer: 0,
        image: '☀️',
      ),
      QuizModel(
        id: 'color_5',
        question: 'What color is an orange?',
        options: ['🔴 Red', '🟠 Orange', '🟢 Green', '🟣 Purple'],
        correctAnswer: 1,
        image: '🍊',
      ),
      QuizModel(
        id: 'color_6',
        question: 'What color is chocolate?',
        options: ['🟤 Brown', '🔴 Red', '🔵 Blue', '⚪ White'],
        correctAnswer: 0,
        image: '🍫',
      ),
      QuizModel(
        id: 'color_7',
        question: 'What color is snow?',
        options: ['⚪ White', '⚫ Black', '🟡 Yellow', '🟢 Green'],
        correctAnswer: 0,
        image: '❄️',
      ),
    ];
  }

  static List<QuizModel> getAnimalQuizzes() {
    return [
      QuizModel(
        id: 'animal_1',
        question: 'Which animal is the king of jungle?',
        options: ['🦁 Lion', '🐘 Elephant', '🐯 Tiger', '🐻 Bear'],
        correctAnswer: 0,
        image: '🦁',
      ),
      QuizModel(
        id: 'animal_2',
        question: 'Which animal has a long trunk?',
        options: ['🦁 Lion', '🐘 Elephant', '🐯 Tiger', '🐻 Bear'],
        correctAnswer: 1,
        image: '🐘',
      ),
      QuizModel(
        id: 'animal_3',
        question: 'Which animal is black and white?',
        options: ['🦁 Lion', '🐼 Panda', '🐯 Tiger', '🐻 Bear'],
        correctAnswer: 1,
        image: '🐼',
      ),
      QuizModel(
        id: 'animal_4',
        question: 'Which animal has a very long neck?',
        options: ['🐻 Bear', '🦓 Zebra', '🦒 Giraffe', '🐵 Monkey'],
        correctAnswer: 2,
        image: '🦒',
      ),
      QuizModel(
        id: 'animal_5',
        question: 'Which animal can hop with a pouch?',
        options: ['🦘 Kangaroo', '🐶 Dog', '🐱 Cat', '🐭 Mouse'],
        correctAnswer: 0,
        image: '🦘',
      ),
      QuizModel(
        id: 'animal_6',
        question: 'Which animal lives in the ocean?',
        options: ['🐘 Elephant', '🐶 Dog', '🐱 Cat', '🐬 Dolphin'],
        correctAnswer: 3,
        image: '🐬',
      ),
    ];
  }

  static List<QuizModel> getFruitQuizzes() {
    return [
      QuizModel(
        id: 'fruit_1',
        question: 'Which fruit is red?',
        options: ['🍎 Apple', '🍌 Banana', '🍊 Orange', '🍇 Grape'],
        correctAnswer: 0,
        image: '🍎',
      ),
      QuizModel(
        id: 'fruit_2',
        question: 'Which fruit is yellow?',
        options: ['🍎 Apple', '🍌 Banana', '🍊 Orange', '🍇 Grape'],
        correctAnswer: 1,
        image: '🍌',
      ),
      QuizModel(
        id: 'fruit_3',
        question: 'Which fruit is orange?',
        options: ['🍎 Apple', '🍌 Banana', '🍊 Orange', '🍇 Grape'],
        correctAnswer: 2,
        image: '🍊',
      ),
      QuizModel(
        id: 'fruit_4',
        question: 'Which fruit is green outside and red inside?',
        options: ['🍌 Banana', '🍉 Watermelon', '🍊 Orange', '🍎 Apple'],
        correctAnswer: 1,
        image: '🍉',
      ),
      QuizModel(
        id: 'fruit_5',
        question: 'Which fruit is long and yellow?',
        options: ['🍎 Apple', '🍌 Banana', '🍇 Grape', '🍊 Orange'],
        correctAnswer: 1,
        image: '🍌',
      ),
      QuizModel(
        id: 'fruit_6',
        question: 'Which fruit has many small purple pieces?',
        options: ['🍎 Apple', '🍌 Banana', '🍊 Orange', '🍇 Grape'],
        correctAnswer: 3,
        image: '🍇',
      ),
    ];
  }

  static List<QuizModel> getFlowerQuizzes() {
    return [
      QuizModel(
        id: 'flower_1',
        question: 'Which flower is red?',
        options: ['🌹 Rose', '🌷 Tulip', '🌸 Cherry Blossom', '🌻 Sunflower'],
        correctAnswer: 0,
        image: '🌹',
      ),
      QuizModel(
        id: 'flower_2',
        question: 'Which flower is yellow?',
        options: ['🌹 Rose', '🌷 Tulip', '🌸 Cherry Blossom', '🌻 Sunflower'],
        correctAnswer: 3,
        image: '🌻',
      ),
      QuizModel(
        id: 'flower_3',
        question: 'Which flower is pink?',
        options: ['🌹 Rose', '🌷 Tulip', '🌸 Cherry Blossom', '🌻 Sunflower'],
        correctAnswer: 2,
        image: '🌸',
      ),
      QuizModel(
        id: 'flower_4',
        question: 'Which is a spring flower?',
        options: ['🌹 Rose', '🌷 Tulip', '🌺 Hibiscus', '🌻 Sunflower'],
        correctAnswer: 1,
        image: '🌷',
      ),
    ];
  }

  static List<QuizModel> getVegetableQuizzes() {
    return [
      QuizModel(
        id: 'veg_1',
        question: 'Which vegetable is orange?',
        options: ['🥕 Carrot', '🥦 Broccoli', '🥒 Cucumber', '🌽 Corn'],
        correctAnswer: 0,
        image: '🥕',
      ),
      QuizModel(
        id: 'veg_2',
        question: 'Which vegetable is green?',
        options: ['🥕 Carrot', '🥦 Broccoli', '🥔 Potato', '🧅 Onion'],
        correctAnswer: 1,
        image: '🥦',
      ),
      QuizModel(
        id: 'veg_3',
        question: 'Which vegetable is spicy?',
        options: ['🥕 Carrot', '🥦 Broccoli', '🌶️ Pepper', '🥒 Cucumber'],
        correctAnswer: 2,
        image: '🌶️',
      ),
      QuizModel(
        id: 'veg_4',
        question: 'Which vegetable is yellow?',
        options: ['🥕 Carrot', '🌽 Corn', '🥦 Broccoli', '🥒 Cucumber'],
        correctAnswer: 1,
        image: '🌽',
      ),
    ];
  }

  static List<QuizModel> getVehicleQuizzes() {
    return [
      QuizModel(
        id: 'vehicle_1',
        question: 'Which vehicle has two wheels?',
        options: ['🚗 Car', '🚲 Bike', '🚌 Bus', '🚚 Truck'],
        correctAnswer: 1,
        image: '🚲',
      ),
      QuizModel(
        id: 'vehicle_2',
        question: 'Which vehicle flies?',
        options: ['🚗 Car', '🚌 Bus', '✈️ Airplane', '🚚 Truck'],
        correctAnswer: 2,
        image: '✈️',
      ),
      QuizModel(
        id: 'vehicle_3',
        question: 'Which vehicle is for emergencies?',
        options: ['🚗 Car', '🚑 Ambulance', '🚌 Bus', '🚚 Truck'],
        correctAnswer: 1,
        image: '🚑',
      ),
      QuizModel(
        id: 'vehicle_4',
        question: 'Which vehicle goes on tracks?',
        options: ['🚗 Car', '🚌 Bus', '🚂 Train', '🚚 Truck'],
        correctAnswer: 2,
        image: '🚂',
      ),
    ];
  }

  static List<QuizModel> getAccessoryQuizzes() {
    return [
      QuizModel(
        id: 'acc_1',
        question: 'What do you wear on your eyes?',
        options: ['👓 Glasses', '👑 Crown', '💍 Ring', '👔 Tie'],
        correctAnswer: 0,
        image: '👓',
      ),
      QuizModel(
        id: 'acc_2',
        question: 'What do you wear on your head?',
        options: ['👓 Glasses', '👑 Crown', '💍 Ring', '👔 Tie'],
        correctAnswer: 1,
        image: '👑',
      ),
      QuizModel(
        id: 'acc_3',
        question: 'What do you wear on your finger?',
        options: ['👓 Glasses', '👑 Crown', '💍 Ring', '👔 Tie'],
        correctAnswer: 2,
        image: '💍',
      ),
      QuizModel(
        id: 'acc_4',
        question: 'What do you wear around your neck?',
        options: ['👓 Glasses', '👑 Crown', '💍 Ring', '👔 Tie'],
        correctAnswer: 3,
        image: '👔',
      ),
    ];
  }

  static List<QuizModel> getClothesQuizzes() {
    return [
      QuizModel(
        id: 'clothes_1',
        question: 'What do you wear on your feet?',
        options: ['👕 Shirt', '👖 Jeans', '👟 Shoes', '👔 Tie'],
        correctAnswer: 2,
        image: '👟',
      ),
      QuizModel(
        id: 'clothes_2',
        question: 'What do you wear on your legs?',
        options: ['👕 Shirt', '👖 Jeans', '👟 Shoes', '👔 Tie'],
        correctAnswer: 1,
        image: '👖',
      ),
      QuizModel(
        id: 'clothes_3',
        question: 'What do you wear on your body?',
        options: ['👕 Shirt', '👖 Jeans', '👟 Shoes', '👔 Tie'],
        correctAnswer: 0,
        image: '👕',
      ),
      QuizModel(
        id: 'clothes_4',
        question: 'What do girls wear?',
        options: ['👕 Shirt', '👖 Jeans', '👗 Dress', '👔 Tie'],
        correctAnswer: 2,
        image: '👗',
      ),
    ];
  }

  static List<LessonModel> getFlowerLessons() {
    return [
      const LessonModel(
        id: 'rose',
        title: 'Rose',
        image: '🌹',
        audio: '',
        description: 'Red flower',
      ),
      const LessonModel(
        id: 'tulip',
        title: 'Tulip',
        image: '🌷',
        audio: '',
        description: 'Spring flower',
      ),
      const LessonModel(
        id: 'cherry_blossom',
        title: 'Cherry Blossom',
        image: '🌸',
        audio: '',
        description: 'Pink flower',
      ),
      const LessonModel(
        id: 'sunflower',
        title: 'Sunflower',
        image: '🌻',
        audio: '',
        description: 'Yellow flower',
      ),
      const LessonModel(
        id: 'hibiscus',
        title: 'Hibiscus',
        image: '🌺',
        audio: '',
        description: 'Tropical flower',
      ),
      const LessonModel(
        id: 'blossom',
        title: 'Blossom',
        image: '🌼',
        audio: '',
        description: 'Small flower',
      ),
      const LessonModel(
        id: 'bouquet',
        title: 'Bouquet',
        image: '💐',
        audio: '',
        description: 'Flower bunch',
      ),
      const LessonModel(
        id: 'wilted_flower',
        title: 'Wilted Flower',
        image: '🥀',
        audio: '',
        description: 'Faded flower',
      ),
    ];
  }

  static List<LessonModel> getVegetableLessons() {
    return [
      const LessonModel(
        id: 'carrot',
        title: 'Carrot',
        image: '🥕',
        audio: '',
        description: 'Orange vegetable',
      ),
      const LessonModel(
        id: 'broccoli',
        title: 'Broccoli',
        image: '🥦',
        audio: '',
        description: 'Green tree',
      ),
      const LessonModel(
        id: 'cucumber',
        title: 'Cucumber',
        image: '🥒',
        audio: '',
        description: 'Green vegetable',
      ),
      const LessonModel(
        id: 'corn',
        title: 'Corn',
        image: '🌽',
        audio: '',
        description: 'Yellow kernels',
      ),
      const LessonModel(
        id: 'pepper',
        title: 'Pepper',
        image: '🌶️',
        audio: '',
        description: 'Spicy vegetable',
      ),
      const LessonModel(
        id: 'potato',
        title: 'Potato',
        image: '🥔',
        audio: '',
        description: 'Brown vegetable',
      ),
      const LessonModel(
        id: 'onion',
        title: 'Onion',
        image: '🧅',
        audio: '',
        description: 'Round vegetable',
      ),
      const LessonModel(
        id: 'garlic',
        title: 'Garlic',
        image: '🧄',
        audio: '',
        description: 'Small bulbs',
      ),
      const LessonModel(
        id: 'mushroom',
        title: 'Mushroom',
        image: '🍄',
        audio: '',
        description: 'Forest food',
      ),
      const LessonModel(
        id: 'peas',
        title: 'Peas',
        image: '🫛',
        audio: '',
        description: 'Green pods',
      ),
      const LessonModel(
        id: 'lettuce',
        title: 'Lettuce',
        image: '🥬',
        audio: '',
        description: 'Green leaves',
      ),
      const LessonModel(
        id: 'cabbage',
        title: 'Cabbage',
        image: '🥬',
        audio: '',
        description: 'Round leaves',
      ),
    ];
  }

  static List<LessonModel> getVehicleLessons() {
    return [
      const LessonModel(
        id: 'car',
        title: 'Car',
        image: '🚗',
        audio: '',
        description: 'Red car',
      ),
      const LessonModel(
        id: 'taxi',
        title: 'Taxi',
        image: '🚕',
        audio: '',
        description: 'Yellow taxi',
      ),
      const LessonModel(
        id: 'bus',
        title: 'Bus',
        image: '🚌',
        audio: '',
        description: 'Big bus',
      ),
      const LessonModel(
        id: 'truck',
        title: 'Truck',
        image: '🚚',
        audio: '',
        description: 'Delivery truck',
      ),
      const LessonModel(
        id: 'police_car',
        title: 'Police Car',
        image: '🚓',
        audio: '',
        description: 'Police vehicle',
      ),
      const LessonModel(
        id: 'ambulance',
        title: 'Ambulance',
        image: '🚑',
        audio: '',
        description: 'Medical vehicle',
      ),
      const LessonModel(
        id: 'fire_truck',
        title: 'Fire Truck',
        image: '🚒',
        audio: '',
        description: 'Fire vehicle',
      ),
      const LessonModel(
        id: 'racing_car',
        title: 'Racing Car',
        image: '🏎️',
        audio: '',
        description: 'Fast car',
      ),
      const LessonModel(
        id: 'motorcycle',
        title: 'Motorcycle',
        image: '🏍️',
        audio: '',
        description: 'Two wheels',
      ),
      const LessonModel(
        id: 'bike',
        title: 'Bike',
        image: '🚲',
        audio: '',
        description: 'Bicycle',
      ),
      const LessonModel(
        id: 'scooter',
        title: 'Scooter',
        image: '🛴',
        audio: '',
        description: 'Kick scooter',
      ),
      const LessonModel(
        id: 'skateboard',
        title: 'Skateboard',
        image: '🛹',
        audio: '',
        description: 'Board with wheels',
      ),
      const LessonModel(
        id: 'train',
        title: 'Train',
        image: '🚂',
        audio: '',
        description: 'Steam train',
      ),
      const LessonModel(
        id: 'metro',
        title: 'Metro',
        image: '🚇',
        audio: '',
        description: 'Subway train',
      ),
      const LessonModel(
        id: 'tram',
        title: 'Tram',
        image: '🚊',
        audio: '',
        description: 'Tram car',
      ),
      const LessonModel(
        id: 'monorail',
        title: 'Monorail',
        image: '🚝',
        audio: '',
        description: 'Single rail',
      ),
      const LessonModel(
        id: 'mountain_railway',
        title: 'Mountain Railway',
        image: '🚞',
        audio: '',
        description: 'Mountain train',
      ),
      const LessonModel(
        id: 'trolleybus',
        title: 'Trolleybus',
        image: '🚋',
        audio: '',
        description: 'Electric bus',
      ),
      const LessonModel(
        id: 'bus_stop',
        title: 'Bus Stop',
        image: '🚏',
        audio: '',
        description: 'Bus station',
      ),
      const LessonModel(
        id: 'minibus',
        title: 'Minibus',
        image: '🚐',
        audio: '',
        description: 'Small bus',
      ),
      const LessonModel(
        id: 'ambulance_2',
        title: 'Ambulance',
        image: '🚨',
        audio: '',
        description: 'Emergency',
      ),
      const LessonModel(
        id: 'police_light',
        title: 'Police Light',
        image: '🚔',
        audio: '',
        description: 'Police car',
      ),
      const LessonModel(
        id: 'oncoming_bus',
        title: 'Oncoming Bus',
        image: '🚍',
        audio: '',
        description: 'Coming bus',
      ),
      const LessonModel(
        id: 'trolley',
        title: 'Trolley',
        image: '🚎',
        audio: '',
        description: 'Trolley car',
      ),
      const LessonModel(
        id: 'pickup_truck',
        title: 'Pickup Truck',
        image: '🛻',
        audio: '',
        description: 'Pickup',
      ),
      const LessonModel(
        id: 'auto_rickshaw',
        title: 'Auto Rickshaw',
        image: '🛺',
        audio: '',
        description: 'Three wheels',
      ),
      const LessonModel(
        id: 'motor_scooter',
        title: 'Motor Scooter',
        image: '🛵',
        audio: '',
        description: 'Motor scooter',
      ),
      const LessonModel(
        id: 'manual_wheelchair',
        title: 'Wheelchair',
        image: '🦽',
        audio: '',
        description: 'Manual chair',
      ),
      const LessonModel(
        id: 'motorized_wheelchair',
        title: 'Motorized Wheelchair',
        image: '🦼',
        audio: '',
        description: 'Electric chair',
      ),
      const LessonModel(
        id: 'airplane',
        title: 'Airplane',
        image: '✈️',
        audio: '',
        description: 'Flying vehicle',
      ),
      const LessonModel(
        id: 'helicopter',
        title: 'Helicopter',
        image: '🚁',
        audio: '',
        description: 'Rotor craft',
      ),
      const LessonModel(
        id: 'suspension_railway',
        title: 'Suspension Railway',
        image: '🚟',
        audio: '',
        description: 'Hanging train',
      ),
      const LessonModel(
        id: 'mountain_cableway',
        title: 'Cable Car',
        image: '🚠',
        audio: '',
        description: 'Cable car',
      ),
      const LessonModel(
        id: 'aerial_tramway',
        title: 'Aerial Tramway',
        image: '🚡',
        audio: '',
        description: 'Tramway',
      ),
      const LessonModel(
        id: 'satellite',
        title: 'Satellite',
        image: '🛰️',
        audio: '',
        description: 'Space vehicle',
      ),
      const LessonModel(
        id: 'rocket',
        title: 'Rocket',
        image: '🚀',
        audio: '',
        description: 'Space rocket',
      ),
      const LessonModel(
        id: 'flying_saucer',
        title: 'Flying Saucer',
        image: '🛸',
        audio: '',
        description: 'UFO',
      ),
      const LessonModel(
        id: 'bellhop_bell',
        title: 'Bell',
        image: '🛎️',
        audio: '',
        description: 'Hotel bell',
      ),
      const LessonModel(
        id: 'luggage',
        title: 'Luggage',
        image: '🧳',
        audio: '',
        description: 'Suitcase',
      ),
      const LessonModel(
        id: 'hourglass',
        title: 'Hourglass',
        image: '⏳',
        audio: '',
        description: 'Timer',
      ),
      const LessonModel(
        id: 'hourglass_done',
        title: 'Hourglass Done',
        image: '⌛',
        audio: '',
        description: 'Time up',
      ),
      const LessonModel(
        id: 'watch',
        title: 'Watch',
        image: '⌚',
        audio: '',
        description: 'Wristwatch',
      ),
      const LessonModel(
        id: 'alarm_clock',
        title: 'Alarm Clock',
        image: '⏰',
        audio: '',
        description: 'Wake up',
      ),
      const LessonModel(
        id: 'stopwatch',
        title: 'Stopwatch',
        image: '⏱️',
        audio: '',
        description: 'Timer',
      ),
      const LessonModel(
        id: 'timer_clock',
        title: 'Timer',
        image: '⏲️',
        audio: '',
        description: 'Cooking timer',
      ),
      const LessonModel(
        id: 'mantelpiece_clock',
        title: 'Clock',
        image: '🕰️',
        audio: '',
        description: 'Wall clock',
      ),
      const LessonModel(
        id: 'twelve_oclock',
        title: '12 O\'Clock',
        image: '🕛',
        audio: '',
        description: 'Noon',
      ),
      const LessonModel(
        id: 'twelve_thirty',
        title: '12:30',
        image: '🕧',
        audio: '',
        description: 'Half past',
      ),
      const LessonModel(
        id: 'one_oclock',
        title: '1 O\'Clock',
        image: '🕐',
        audio: '',
        description: 'One',
      ),
      const LessonModel(
        id: 'one_thirty',
        title: '1:30',
        image: '🕜',
        audio: '',
        description: 'Half past one',
      ),
      const LessonModel(
        id: 'two_oclock',
        title: '2 O\'Clock',
        image: '🕑',
        audio: '',
        description: 'Two',
      ),
      const LessonModel(
        id: 'two_thirty',
        title: '2:30',
        image: '🕝',
        audio: '',
        description: 'Half past two',
      ),
      const LessonModel(
        id: 'three_oclock',
        title: '3 O\'Clock',
        image: '🕒',
        audio: '',
        description: 'Three',
      ),
      const LessonModel(
        id: 'three_thirty',
        title: '3:30',
        image: '🕞',
        audio: '',
        description: 'Half past three',
      ),
      const LessonModel(
        id: 'four_oclock',
        title: '4 O\'Clock',
        image: '🕓',
        audio: '',
        description: 'Four',
      ),
      const LessonModel(
        id: 'four_thirty',
        title: '4:30',
        image: '🕟',
        audio: '',
        description: 'Half past four',
      ),
      const LessonModel(
        id: 'five_oclock',
        title: '5 O\'Clock',
        image: '🕔',
        audio: '',
        description: 'Five',
      ),
      const LessonModel(
        id: 'five_thirty',
        title: '5:30',
        image: '🕠',
        audio: '',
        description: 'Half past five',
      ),
      const LessonModel(
        id: 'six_oclock',
        title: '6 O\'Clock',
        image: '🕕',
        audio: '',
        description: 'Six',
      ),
      const LessonModel(
        id: 'six_thirty',
        title: '6:30',
        image: '🕡',
        audio: '',
        description: 'Half past six',
      ),
      const LessonModel(
        id: 'seven_oclock',
        title: '7 O\'Clock',
        image: '🕖',
        audio: '',
        description: 'Seven',
      ),
      const LessonModel(
        id: 'seven_thirty',
        title: '7:30',
        image: '🕢',
        audio: '',
        description: 'Half past seven',
      ),
      const LessonModel(
        id: 'eight_oclock',
        title: '8 O\'Clock',
        image: '🕗',
        audio: '',
        description: 'Eight',
      ),
      const LessonModel(
        id: 'eight_thirty',
        title: '8:30',
        image: '🕣',
        audio: '',
        description: 'Half past eight',
      ),
      const LessonModel(
        id: 'nine_oclock',
        title: '9 O\'Clock',
        image: '🕘',
        audio: '',
        description: 'Nine',
      ),
      const LessonModel(
        id: 'nine_thirty',
        title: '9:30',
        image: '🕤',
        audio: '',
        description: 'Half past nine',
      ),
      const LessonModel(
        id: 'ten_oclock',
        title: '10 O\'Clock',
        image: '🕙',
        audio: '',
        description: 'Ten',
      ),
      const LessonModel(
        id: 'ten_thirty',
        title: '10:30',
        image: '🕥',
        audio: '',
        description: 'Half past ten',
      ),
      const LessonModel(
        id: 'eleven_oclock',
        title: '11 O\'Clock',
        image: '🕚',
        audio: '',
        description: 'Eleven',
      ),
      const LessonModel(
        id: 'eleven_thirty',
        title: '11:30',
        image: '🕦',
        audio: '',
        description: 'Half past eleven',
      ),
      const LessonModel(
        id: 'new_moon',
        title: 'New Moon',
        image: '🌑',
        audio: '',
        description: 'Dark moon',
      ),
      const LessonModel(
        id: 'waxing_crescent',
        title: 'Waxing Crescent',
        image: '🌒',
        audio: '',
        description: 'Growing moon',
      ),
      const LessonModel(
        id: 'first_quarter',
        title: 'First Quarter',
        image: '🌓',
        audio: '',
        description: 'Half moon',
      ),
      const LessonModel(
        id: 'waxing_gibbous',
        title: 'Waxing Gibbous',
        image: '🌔',
        audio: '',
        description: 'Almost full',
      ),
      const LessonModel(
        id: 'full_moon',
        title: 'Full Moon',
        image: '🌕',
        audio: '',
        description: 'Round moon',
      ),
      const LessonModel(
        id: 'waning_gibbous',
        title: 'Waning Gibbous',
        image: '🌖',
        audio: '',
        description: 'Shrinking',
      ),
      const LessonModel(
        id: 'last_quarter',
        title: 'Last Quarter',
        image: '🌗',
        audio: '',
        description: 'Half moon',
      ),
      const LessonModel(
        id: 'waning_crescent',
        title: 'Waning Crescent',
        image: '🌘',
        audio: '',
        description: 'Small moon',
      ),
      const LessonModel(
        id: 'crescent_moon',
        title: 'Crescent Moon',
        image: '🌙',
        audio: '',
        description: 'Crescent',
      ),
      const LessonModel(
        id: 'new_moon_face',
        title: 'New Moon Face',
        image: '🌚',
        audio: '',
        description: 'Moon face',
      ),
      const LessonModel(
        id: 'first_quarter_face',
        title: 'First Quarter Face',
        image: '🌛',
        audio: '',
        description: 'Half face',
      ),
      const LessonModel(
        id: 'last_quarter_face',
        title: 'Last Quarter Face',
        image: '🌜',
        audio: '',
        description: 'Half face',
      ),
      const LessonModel(
        id: 'thermometer',
        title: 'Thermometer',
        image: '🌡️',
        audio: '',
        description: 'Temperature',
      ),
      const LessonModel(
        id: 'sunny',
        title: 'Sunny',
        image: '☀️',
        audio: '',
        description: 'Sun',
      ),
      const LessonModel(
        id: 'full_moon_face',
        title: 'Full Moon Face',
        image: '🌝',
        audio: '',
        description: 'Happy moon',
      ),
      const LessonModel(
        id: 'sun_with_face',
        title: 'Sun with Face',
        image: '🌞',
        audio: '',
        description: 'Happy sun',
      ),
      const LessonModel(
        id: 'ringed_planet',
        title: 'Ringed Planet',
        image: '🪐',
        audio: '',
        description: 'Saturn',
      ),
      const LessonModel(
        id: 'star',
        title: 'Star',
        image: '⭐',
        audio: '',
        description: 'Bright star',
      ),
      const LessonModel(
        id: 'glowing_star',
        title: 'Glowing Star',
        image: '🌟',
        audio: '',
        description: 'Shining star',
      ),
      const LessonModel(
        id: 'shooting_star',
        title: 'Shooting Star',
        image: '💫',
        audio: '',
        description: 'Falling star',
      ),
      const LessonModel(
        id: 'milky_way',
        title: 'Milky Way',
        image: '🌌',
        audio: '',
        description: 'Galaxy',
      ),
      const LessonModel(
        id: 'cloud',
        title: 'Cloud',
        image: '☁️',
        audio: '',
        description: 'White cloud',
      ),
      const LessonModel(
        id: 'sun_behind_cloud',
        title: 'Sun Behind Cloud',
        image: '⛅',
        audio: '',
        description: 'Partly cloudy',
      ),
      const LessonModel(
        id: 'cloud_with_lightning',
        title: 'Cloud with Lightning',
        image: '⛈️',
        audio: '',
        description: 'Storm',
      ),
      const LessonModel(
        id: 'sun_behind_small_cloud',
        title: 'Sun Behind Small Cloud',
        image: '🌤️',
        audio: '',
        description: 'Light cloud',
      ),
      const LessonModel(
        id: 'sun_behind_large_cloud',
        title: 'Sun Behind Large Cloud',
        image: '🌥️',
        audio: '',
        description: 'Heavy cloud',
      ),
      const LessonModel(
        id: 'sun_behind_rain_cloud',
        title: 'Sun Behind Rain Cloud',
        image: '🌦️',
        audio: '',
        description: 'Rainy',
      ),
      const LessonModel(
        id: 'cloud_with_rain',
        title: 'Cloud with Rain',
        image: '🌧️',
        audio: '',
        description: 'Raining',
      ),
      const LessonModel(
        id: 'cloud_with_snow',
        title: 'Cloud with Snow',
        image: '🌨️',
        audio: '',
        description: 'Snowing',
      ),
      const LessonModel(
        id: 'cloud_with_lightning_rain',
        title: 'Cloud with Lightning Rain',
        image: '🌩️',
        audio: '',
        description: 'Thunderstorm',
      ),
      const LessonModel(
        id: 'tornado',
        title: 'Tornado',
        image: '🌪️',
        audio: '',
        description: 'Tornado',
      ),
      const LessonModel(
        id: 'fog',
        title: 'Fog',
        image: '🌫️',
        audio: '',
        description: 'Foggy',
      ),
      const LessonModel(
        id: 'wind_face',
        title: 'Wind Face',
        image: '💨',
        audio: '',
        description: 'Windy',
      ),
      const LessonModel(
        id: 'cyclone',
        title: 'Cyclone',
        image: '🌀',
        audio: '',
        description: 'Hurricane',
      ),
      const LessonModel(
        id: 'rainbow',
        title: 'Rainbow',
        image: '🌈',
        audio: '',
        description: 'Colorful arc',
      ),
      const LessonModel(
        id: 'closed_umbrella',
        title: 'Closed Umbrella',
        image: '🌂',
        audio: '',
        description: 'Folded umbrella',
      ),
      const LessonModel(
        id: 'open_umbrella',
        title: 'Open Umbrella',
        image: '☂️',
        audio: '',
        description: 'Open umbrella',
      ),
      const LessonModel(
        id: 'umbrella_rain',
        title: 'Umbrella with Rain',
        image: '☔',
        audio: '',
        description: 'Rain umbrella',
      ),
      const LessonModel(
        id: 'parasol',
        title: 'Parasol',
        image: '🌂',
        audio: '',
        description: 'Beach umbrella',
      ),
      const LessonModel(
        id: 'high_voltage',
        title: 'High Voltage',
        image: '⚡',
        audio: '',
        description: 'Lightning',
      ),
      const LessonModel(
        id: 'snowflake',
        title: 'Snowflake',
        image: '❄️',
        audio: '',
        description: 'Ice crystal',
      ),
      const LessonModel(
        id: 'snowman',
        title: 'Snowman',
        image: '☃️',
        audio: '',
        description: 'Snow person',
      ),
      const LessonModel(
        id: 'snowman_no_snow',
        title: 'Snowman No Snow',
        image: '⛄',
        audio: '',
        description: 'Melted snowman',
      ),
      const LessonModel(
        id: 'comet',
        title: 'Comet',
        image: '☄️',
        audio: '',
        description: 'Space rock',
      ),
      const LessonModel(
        id: 'fire',
        title: 'Fire',
        image: '🔥',
        audio: '',
        description: 'Flame',
      ),
      const LessonModel(
        id: 'droplet',
        title: 'Droplet',
        image: '💧',
        audio: '',
        description: 'Water drop',
      ),
      const LessonModel(
        id: 'ocean',
        title: 'Ocean',
        image: '🌊',
        audio: '',
        description: 'Water wave',
      ),
    ];
  }

  static List<LessonModel> getAccessoryLessons() {
    return [
      const LessonModel(
        id: 'glasses',
        title: 'Glasses',
        image: '👓',
        audio: '',
        description: 'Eyeglasses',
      ),
      const LessonModel(
        id: 'sunglasses',
        title: 'Sunglasses',
        image: '🕶️',
        audio: '',
        description: 'Dark glasses',
      ),
      const LessonModel(
        id: 'goggles',
        title: 'Goggles',
        image: '🥽',
        audio: '',
        description: 'Safety glasses',
      ),
      const LessonModel(
        id: 'lab_coat',
        title: 'Lab Coat',
        image: '🥼',
        audio: '',
        description: 'Doctor coat',
      ),
      const LessonModel(
        id: 'safety_vest',
        title: 'Safety Vest',
        image: '🦺',
        audio: '',
        description: 'Reflective vest',
      ),
      const LessonModel(
        id: 'necktie',
        title: 'Necktie',
        image: '👔',
        audio: '',
        description: 'Tie',
      ),
      const LessonModel(
        id: 'shirt',
        title: 'Shirt',
        image: '👕',
        audio: '',
        description: 'T-shirt',
      ),
      const LessonModel(
        id: 'jeans',
        title: 'Jeans',
        image: '👖',
        audio: '',
        description: 'Denim pants',
      ),
      const LessonModel(
        id: 'scarf',
        title: 'Scarf',
        image: '🧣',
        audio: '',
        description: 'Warm scarf',
      ),
      const LessonModel(
        id: 'gloves',
        title: 'Gloves',
        image: '🧤',
        audio: '',
        description: 'Hand covers',
      ),
      const LessonModel(
        id: 'coat',
        title: 'Coat',
        image: '🧥',
        audio: '',
        description: 'Jacket',
      ),
      const LessonModel(
        id: 'socks',
        title: 'Socks',
        image: '🧦',
        audio: '',
        description: 'Foot covers',
      ),
      const LessonModel(
        id: 'dress',
        title: 'Dress',
        image: '👗',
        audio: '',
        description: 'Girl dress',
      ),
      const LessonModel(
        id: 'kimono',
        title: 'Kimono',
        image: '👘',
        audio: '',
        description: 'Japanese dress',
      ),
      const LessonModel(
        id: 'sari',
        title: 'Sari',
        image: '🥻',
        audio: '',
        description: 'Indian dress',
      ),
      const LessonModel(
        id: 'one_piece',
        title: 'One Piece',
        image: '🩱',
        audio: '',
        description: 'Swimsuit',
      ),
      const LessonModel(
        id: 'briefs',
        title: 'Briefs',
        image: '🩲',
        audio: '',
        description: 'Underwear',
      ),
      const LessonModel(
        id: 'shorts',
        title: 'Shorts',
        image: '🩳',
        audio: '',
        description: 'Short pants',
      ),
      const LessonModel(
        id: 'womans_clothes',
        title: 'Woman\'s Clothes',
        image: '👚',
        audio: '',
        description: 'Blouse',
      ),
      const LessonModel(
        id: 'purse',
        title: 'Purse',
        image: '👛',
        audio: '',
        description: 'Handbag',
      ),
      const LessonModel(
        id: 'handbag',
        title: 'Handbag',
        image: '👜',
        audio: '',
        description: 'Bag',
      ),
      const LessonModel(
        id: 'clutch',
        title: 'Clutch',
        image: '👝',
        audio: '',
        description: 'Small bag',
      ),
      const LessonModel(
        id: 'shopping_bags',
        title: 'Shopping Bags',
        image: '🛍️',
        audio: '',
        description: 'Shopping',
      ),
      const LessonModel(
        id: 'backpack',
        title: 'Backpack',
        image: '🎒',
        audio: '',
        description: 'School bag',
      ),
      const LessonModel(
        id: 'thong_sandal',
        title: 'Thong Sandal',
        image: '🩴',
        audio: '',
        description: 'Flip flop',
      ),
      const LessonModel(
        id: 'mans_shoe',
        title: 'Man\'s Shoe',
        image: '👞',
        audio: '',
        description: 'Dress shoe',
      ),
      const LessonModel(
        id: 'running_shoe',
        title: 'Running Shoe',
        image: '👟',
        audio: '',
        description: 'Sneaker',
      ),
      const LessonModel(
        id: 'hiking_boot',
        title: 'Hiking Boot',
        image: '🥾',
        audio: '',
        description: 'Boot',
      ),
      const LessonModel(
        id: 'flat_shoe',
        title: 'Flat Shoe',
        image: '🥿',
        audio: '',
        description: 'Flat',
      ),
      const LessonModel(
        id: 'high_heel',
        title: 'High Heel',
        image: '👠',
        audio: '',
        description: 'Heel',
      ),
      const LessonModel(
        id: 'sandal',
        title: 'Sandal',
        image: '👡',
        audio: '',
        description: 'Sandal',
      ),
      const LessonModel(
        id: 'ballet_shoes',
        title: 'Ballet Shoes',
        image: '🩰',
        audio: '',
        description: 'Dance shoes',
      ),
      const LessonModel(
        id: 'womans_boot',
        title: 'Woman\'s Boot',
        image: '👢',
        audio: '',
        description: 'Boot',
      ),
      const LessonModel(
        id: 'crown',
        title: 'Crown',
        image: '👑',
        audio: '',
        description: 'King crown',
      ),
      const LessonModel(
        id: 'womans_hat',
        title: 'Woman\'s Hat',
        image: '👒',
        audio: '',
        description: 'Hat',
      ),
      const LessonModel(
        id: 'top_hat',
        title: 'Top Hat',
        image: '🎩',
        audio: '',
        description: 'Formal hat',
      ),
      const LessonModel(
        id: 'mortar_board',
        title: 'Graduation Cap',
        image: '🎓',
        audio: '',
        description: 'School cap',
      ),
      const LessonModel(
        id: 'billed_cap',
        title: 'Billed Cap',
        image: '🧢',
        audio: '',
        description: 'Baseball cap',
      ),
      const LessonModel(
        id: 'military_helmet',
        title: 'Military Helmet',
        image: '🪖',
        audio: '',
        description: 'Army helmet',
      ),
      const LessonModel(
        id: 'rescue_helmet',
        title: 'Rescue Helmet',
        image: '⛑️',
        audio: '',
        description: 'Safety helmet',
      ),
      const LessonModel(
        id: 'prayer_beads',
        title: 'Prayer Beads',
        image: '📿',
        audio: '',
        description: 'Beads',
      ),
      const LessonModel(
        id: 'lipstick',
        title: 'Lipstick',
        image: '💄',
        audio: '',
        description: 'Makeup',
      ),
      const LessonModel(
        id: 'ring',
        title: 'Ring',
        image: '💍',
        audio: '',
        description: 'Jewelry',
      ),
      const LessonModel(
        id: 'gem',
        title: 'Gem',
        image: '💎',
        audio: '',
        description: 'Diamond',
      ),
    ];
  }

  static List<LessonModel> getClothesLessons() {
    return [
      const LessonModel(
        id: 'shirt_2',
        title: 'Shirt',
        image: '👕',
        audio: '',
        description: 'T-shirt',
      ),
      const LessonModel(
        id: 'jeans_2',
        title: 'Jeans',
        image: '👖',
        audio: '',
        description: 'Denim pants',
      ),
      const LessonModel(
        id: 'kimono_2',
        title: 'Kimono',
        image: '👘',
        audio: '',
        description: 'Japanese dress',
      ),
      const LessonModel(
        id: 'sari_2',
        title: 'Sari',
        image: '🥻',
        audio: '',
        description: 'Indian dress',
      ),
      const LessonModel(
        id: 'one_piece_2',
        title: 'One Piece',
        image: '🩱',
        audio: '',
        description: 'Swimsuit',
      ),
      const LessonModel(
        id: 'briefs_2',
        title: 'Briefs',
        image: '🩲',
        audio: '',
        description: 'Underwear',
      ),
      const LessonModel(
        id: 'shorts_2',
        title: 'Shorts',
        image: '🩳',
        audio: '',
        description: 'Short pants',
      ),
      const LessonModel(
        id: 'womans_clothes_2',
        title: 'Woman\'s Clothes',
        image: '👚',
        audio: '',
        description: 'Blouse',
      ),
      const LessonModel(
        id: 'scarf_2',
        title: 'Scarf',
        image: '🧣',
        audio: '',
        description: 'Warm scarf',
      ),
      const LessonModel(
        id: 'gloves_2',
        title: 'Gloves',
        image: '🧤',
        audio: '',
        description: 'Hand covers',
      ),
      const LessonModel(
        id: 'coat_2',
        title: 'Coat',
        image: '🧥',
        audio: '',
        description: 'Jacket',
      ),
      const LessonModel(
        id: 'socks_2',
        title: 'Socks',
        image: '🧦',
        audio: '',
        description: 'Foot covers',
      ),
      const LessonModel(
        id: 'necktie_2',
        title: 'Necktie',
        image: '👔',
        audio: '',
        description: 'Tie',
      ),
      const LessonModel(
        id: 'mans_shoe_2',
        title: 'Man\'s Shoe',
        image: '👞',
        audio: '',
        description: 'Dress shoe',
      ),
      const LessonModel(
        id: 'running_shoe_2',
        title: 'Running Shoe',
        image: '👟',
        audio: '',
        description: 'Sneaker',
      ),
      const LessonModel(
        id: 'hiking_boot_2',
        title: 'Hiking Boot',
        image: '🥾',
        audio: '',
        description: 'Boot',
      ),
      const LessonModel(
        id: 'flat_shoe_2',
        title: 'Flat Shoe',
        image: '🥿',
        audio: '',
        description: 'Flat',
      ),
      const LessonModel(
        id: 'high_heel_2',
        title: 'High Heel',
        image: '👠',
        audio: '',
        description: 'Heel',
      ),
      const LessonModel(
        id: 'sandal_2',
        title: 'Sandal',
        image: '👡',
        audio: '',
        description: 'Sandal',
      ),
      const LessonModel(
        id: 'ballet_shoes_2',
        title: 'Ballet Shoes',
        image: '🩰',
        audio: '',
        description: 'Dance shoes',
      ),
      const LessonModel(
        id: 'womans_boot_2',
        title: 'Woman\'s Boot',
        image: '👢',
        audio: '',
        description: 'Boot',
      ),
      const LessonModel(
        id: 'thong_sandal_2',
        title: 'Thong Sandal',
        image: '🩴',
        audio: '',
        description: 'Flip flop',
      ),
      const LessonModel(
        id: 'crown_2',
        title: 'Crown',
        image: '👑',
        audio: '',
        description: 'King crown',
      ),
      const LessonModel(
        id: 'womans_hat_2',
        title: 'Woman\'s Hat',
        image: '👒',
        audio: '',
        description: 'Hat',
      ),
      const LessonModel(
        id: 'top_hat_2',
        title: 'Top Hat',
        image: '🎩',
        audio: '',
        description: 'Formal hat',
      ),
      const LessonModel(
        id: 'mortar_board_2',
        title: 'Graduation Cap',
        image: '🎓',
        audio: '',
        description: 'School cap',
      ),
      const LessonModel(
        id: 'billed_cap_2',
        title: 'Billed Cap',
        image: '🧢',
        audio: '',
        description: 'Baseball cap',
      ),
      const LessonModel(
        id: 'military_helmet_2',
        title: 'Military Helmet',
        image: '🪖',
        audio: '',
        description: 'Army helmet',
      ),
      const LessonModel(
        id: 'rescue_helmet_2',
        title: 'Rescue Helmet',
        image: '⛑️',
        audio: '',
        description: 'Safety helmet',
      ),
    ];
  }

  // Mixed lessons combining all categories
  static List<LessonModel> getMixedLessons() {
    final List<LessonModel> mixed = [];

    // Add a few from each category
    final alphabets = getAlphabetLessons();
    final numbers = getNumberLessons();
    final shapes = getShapeLessons();
    final colors = getColorLessons();
    final animals = getAnimalLessons();
    final fruits = getFruitLessons();
    final bodyParts = getBodyPartLessons();

    // Mix them up - take samples from each category
    final flowers = getFlowerLessons();
    final vegetables = getVegetableLessons();
    final vehicles = getVehicleLessons();
    final accessories = getAccessoryLessons();
    final clothes = getClothesLessons();

    mixed.addAll(alphabets.take(5)); // A-E
    mixed.addAll(numbers.take(3)); // 1-3
    mixed.addAll(shapes.take(4)); // Circle, Square, Triangle, Star
    mixed.addAll(colors.take(4)); // Red, Blue, Green, Yellow
    mixed.addAll(animals.take(6)); // Various animals
    mixed.addAll(fruits.take(5)); // Various fruits
    mixed.addAll(bodyParts.take(5)); // Head, Eyes, Hand, etc.
    mixed.addAll(flowers.take(4)); // Various flowers
    mixed.addAll(vegetables.take(4)); // Various vegetables
    mixed.addAll(vehicles.take(5)); // Various vehicles
    mixed.addAll(accessories.take(4)); // Various accessories
    mixed.addAll(clothes.take(4)); // Various clothes

    // Shuffle to mix them up
    mixed.shuffle();

    return mixed;
  }

  // Mixed quizzes combining all categories
  static List<QuizModel> getMixedQuizzes() {
    final List<QuizModel> mixed = [];

    // Get quizzes from all categories
    final alphabetQuizzes = getAlphabetQuizzes();
    final numberQuizzes = getNumberQuizzes();
    final shapeQuizzes = getShapeQuizzes();
    final colorQuizzes = getColorQuizzes();
    final animalQuizzes = getAnimalQuizzes();
    final fruitQuizzes = getFruitQuizzes();

    // Take samples from each category
    final flowerQuizzes = getFlowerQuizzes();
    final vegetableQuizzes = getVegetableQuizzes();
    final vehicleQuizzes = getVehicleQuizzes();
    final accessoryQuizzes = getAccessoryQuizzes();
    final clothesQuizzes = getClothesQuizzes();

    mixed.addAll(alphabetQuizzes.take(3)); // 3 alphabet questions
    mixed.addAll(numberQuizzes.take(3)); // 3 number questions
    mixed.addAll(shapeQuizzes.take(2)); // 2 shape questions
    mixed.addAll(colorQuizzes.take(2)); // 2 color questions
    mixed.addAll(animalQuizzes.take(3)); // 3 animal questions
    mixed.addAll(fruitQuizzes.take(2)); // 2 fruit questions
    mixed.addAll(flowerQuizzes.take(2)); // 2 flower questions
    mixed.addAll(vegetableQuizzes.take(2)); // 2 vegetable questions
    mixed.addAll(vehicleQuizzes.take(2)); // 2 vehicle questions
    mixed.addAll(accessoryQuizzes.take(2)); // 2 accessory questions
    mixed.addAll(clothesQuizzes.take(2)); // 2 clothes questions

    // Shuffle to mix them up
    mixed.shuffle();

    return mixed;
  }
}
