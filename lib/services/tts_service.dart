import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

/// System text-to-speech (no MP3 assets). Use for letters, words, praise.
/// Stopped when app backgrounds via [stop] from lifecycle.
class TtsService extends GetxController {
  static TtsService get to => Get.find();

  late FlutterTts _flutterTts;
  bool _isInitialized = false;
  final RxBool isPlaying = false.obs;
  final RxString caption = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  Future<void> _initTts() async {
    _flutterTts = FlutterTts();

    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.2);

    try {
      await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        ],
        IosTextToSpeechAudioMode.spokenAudio,
      );
    } catch (_) {}

    _flutterTts.setCompletionHandler(() {
      isPlaying.value = false;
    });

    _flutterTts.setErrorHandler((_) {
      isPlaying.value = false;
    });

    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    await _speakRaw(text, captionText: text);
  }

  Future<void> _speakRaw(String text, {String? captionText}) async {
    if (!_isInitialized) {
      await _initTts();
    }

    if (isPlaying.value) {
      await stop();
    }

    if (captionText != null) caption.value = captionText;
    isPlaying.value = true;
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    if (_isInitialized) {
      await _flutterTts.stop();
      isPlaying.value = false;
    }
  }

  void clearCaption() {
    caption.value = '';
  }

  Future<void> pause() async {
    if (_isInitialized) {
      await _flutterTts.pause();
    }
  }

  Future<void> speakLetter(String letter) async {
    final l = letter.trim().toUpperCase();
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

    final word = words[l] ?? l;
    caption.value = '$l for $word';

    final letterSounds = <String, String>{
      'A': 'ay',
      'B': 'bee',
      'C': 'see',
      'D': 'dee',
      'E': 'ee',
      'F': 'ef',
      'G': 'jee',
      'H': 'aitch',
      'I': 'eye',
      'J': 'jay',
      'K': 'kay',
      'L': 'el',
      'M': 'em',
      'N': 'en',
      'O': 'oh',
      'P': 'pee',
      'Q': 'cue',
      'R': 'ar',
      'S': 'es',
      'T': 'tee',
      'U': 'you',
      'V': 'vee',
      'W': 'double you',
      'X': 'ex',
      'Y': 'why',
      'Z': 'zee',
    };

    final sound = letterSounds[l] ?? l.toLowerCase();
    await _speakRaw('$sound for $word', captionText: null);
  }

  Future<void> speakNumber(int number) async {
    final numberWords = <int, String>{
      1: 'one',
      2: 'two',
      3: 'three',
      4: 'four',
      5: 'five',
      6: 'six',
      7: 'seven',
      8: 'eight',
      9: 'nine',
      10: 'ten',
    };
    final text = numberWords[number] ?? number.toString();
    caption.value = number.toString();
    await _speakRaw(text, captionText: null);
  }

  Future<void> speakWord(String word) async {
    await speak(word);
  }

  /// Short praise phrases for games / flows.
  Future<void> speakEncouragement(String phrase) async {
    await speakWord(phrase);
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
